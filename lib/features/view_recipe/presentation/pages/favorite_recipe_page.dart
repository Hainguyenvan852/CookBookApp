import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/bloc/recipe_view_bloc.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/bloc/recipe_view_state.dart';

import '../../../../core/themes/main_theme.dart';
import '../../data/models/favorite_model.dart';
import '../../data/models/recipe_model.dart';
import '../bloc/recipe_view_event.dart';
import '../widgets/recipe_card_type_4.dart';

class FavoriteRecipePage extends StatefulWidget {
  const FavoriteRecipePage({super.key, required this.user});
  final UserModel user;

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
                          _buildSearchAndFilter(recipeNumber: state.favoriteList.length),
                          const SizedBox(height: 20,),
                          _buildRecipeList(recipes: state.favoriteList)
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
        TextFormField(
          cursorColor: ColorThemes.primaryAccent,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.transparent, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.transparent, width: 1),
              ),
              fillColor: ColorThemes.inputFieldBackground2,
              filled: true,
              hintText: 'Search recipes . . .',
              hintStyle: TextStyle(
                  color: ColorThemes.textSecondary,
                  fontSize: FontSizeThemes.mediumFont
              ),
              prefixIcon: Icon(Icons.search_rounded, color: ColorThemes.primaryAccent,),
              suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.mic, color: ColorThemes.textSecondary,))
          ),
        ),

        const SizedBox(height: 20,),

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
              onTap: (){},
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
