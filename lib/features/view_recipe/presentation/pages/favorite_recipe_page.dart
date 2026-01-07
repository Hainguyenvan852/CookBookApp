import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/bloc/recipe_view/recipe_view_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/themes/main_theme.dart';
import '../../data/models/favorite_model.dart';
import '../../data/models/recipe_model.dart';
import '../bloc/recipe_view/recipe_view_event.dart';
import '../bloc/recipe_view/recipe_view_state.dart';
import '../widgets/recipe_card_type_4.dart';

class FavoriteRecipePage extends StatefulWidget {
  const FavoriteRecipePage({super.key, required this.user, required this.supabaseClient});
  final UserModel user;
  final SupabaseClient supabaseClient;

  @override
  State<FavoriteRecipePage> createState() => _FavoriteRecipePageState();
}

class _FavoriteRecipePageState extends State<FavoriteRecipePage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              const SizedBox(height: 20,),
              BlocBuilder<RecipeViewBloc, RecipeViewState>(
                builder: (context, state){

                  if(state.isLoading){
                    return SizedBox(
                      height: 600,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorThemes.primaryAccent,
                        ),
                      ),
                    );
                  }

                  if(state.error != null){
                    return SizedBox(
                      height: 400,
                      child: Center(
                        child: Text(state.error!),
                      ),
                    );
                  }

                  return Builder(
                    builder: (context){
                      return Column(
                        children: [
                          _buildSearchAndFilter(recipeNumber: state.favoriteListByFilter.length),
                          const SizedBox(height: 20,),
                          _buildRecipeList(recipes: state.favoriteListByFilter)
                        ],
                      );
                    }
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          'Saved recipes',
          style: TextStyle(
              color: ColorThemes.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter({
    required int recipeNumber
  }){
    return Column(
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$recipeNumber saved recipes',
              style: TextStyle(
                  color: Color(0xFF8FB79F),
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
            GestureDetector(
              onTap: (){
                showMenu(
                  color: Colors.black38,
                  position: RelativeRect.fromLTRB(10, 130, 0, 0),
                  context: context,
                  items: [
                    PopupMenuItem(
                        child: TextButton(
                            onPressed: (){
                              context.read<RecipeViewBloc>().add(FilterFavoriteListPressed('all'));
                            },
                            child: Text('Tất cả', style: TextStyle(color: Colors.white),)
                        )
                    ),
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: (){
                          context.read<RecipeViewBloc>().add(FilterFavoriteListPressed('breakfast'));
                        },
                        child: Text('Breakfast', style: TextStyle(color: Colors.white),)
                      )
                    ),
                    PopupMenuItem(
                        child: TextButton(
                          onPressed: () {
                            context.read<RecipeViewBloc>().add(FilterFavoriteListPressed('lunch'));
                          },
                          child: Text('Lunch', style: TextStyle(color: Colors.white),)
                        )
                    ),
                    PopupMenuItem(
                        child: TextButton(
                          onPressed: () {
                            context.read<RecipeViewBloc>().add(FilterFavoriteListPressed('dinner'));
                          },
                          child: Text('Dinner', style: TextStyle(color: Colors.white),)
                        )
                    )
                  ]
                );
              },
              child: Row(
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(
                        color: ColorThemes.primaryAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Icon(
                    Icons.sort_rounded,
                    color: ColorThemes.primaryAccent,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildRecipeList({
    required List<RecipeModel> recipes
  }){
    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: recipes.map((recipe){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipeCardType4(
                recipe: recipe,
                onPressed: (){
                  if(recipe.isFavorite!){
                    final favorite = FavoriteModel(userId: widget.user.id, recipeId: recipe.id);
                    context.read<RecipeViewBloc>().add(NoFavoritePressed(favoriteModel: favorite));
                  }else{
                    final favorite = FavoriteModel(userId: widget.user.id, recipeId: recipe.id);
                    context.read<RecipeViewBloc>().add(FavoritePressed(favoriteModel: favorite));
                  }
                },
                user: widget.user,
                supabaseClient: widget.supabaseClient,
              ),
              const SizedBox(height: 10,),
              Text(
                recipe.dishName,
                style: TextStyle(
                    fontSize: FontSizeThemes.regularFont,
                    color: ColorThemes.textPrimary,
                    fontWeight: FontWeight.bold
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.local_fire_department_rounded, color: Colors.deepOrange,size: 20,),
                  const SizedBox(width: 5,),
                  Text(
                    'Easy - Breakfast',
                    style: TextStyle(
                      fontSize: FontSizeThemes.smallFont,
                      color: ColorThemes.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
