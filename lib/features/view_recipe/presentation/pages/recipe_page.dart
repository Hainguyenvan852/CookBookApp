import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/widgets/recipe_card_type_4.dart';

import '../../../../core/themes/main_theme.dart';
import '../../data/models/favorite_model.dart';
import '../bloc/recipe_view_bloc.dart';
import '../bloc/recipe_view_event.dart';
import '../bloc/recipe_view_state.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.user});
  final UserModel user;

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {

  final tabs = ['Popular', 'Breakfast', 'Lunch', 'Dinner'];

  String _selectedTab = 'Popular';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      'All recipes',
                      style: TextStyle(
                          color: ColorThemes.textPrimary,
                          fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Discover your next meal',
                      style: TextStyle(
                          color: ColorThemes.textSecondary,
                          fontSize: FontSizeThemes.regularFont
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorThemes.cardBackground
                  ),
                  child: SvgPicture.asset("lib/core/icons/chef-hat.svg", width: 35,)
                ),
              ],
            ),
            const SizedBox(height: 20,),
            TextFormField(
              cursorColor: Colors.white,
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
            DefaultTabController(
              length: tabs.length,
              child: ButtonsTabBar(
                radius: 50,
                duration: 250,
                unselectedBackgroundColor: ColorThemes.iconBackground,
                unselectedLabelStyle: TextStyle(color: ColorThemes.textSecondary),
                decoration: BoxDecoration(
                  color: ColorThemes.primaryAccent,
                  borderRadius: BorderRadius.circular(50),
                ),
                buttonMargin: EdgeInsets.symmetric(horizontal: 10,),
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 25),
                onTap: (index){
                  setState(() {
                    _selectedTab = tabs[index];
                  });
                },
                tabs: tabs.map((tab) => Tab(
                  text: tab,
                  icon: tab.toLowerCase() == 'popular' ? Icon(Icons.local_fire_department, size: 18) : null,
                )).toList(),
              ),
            ),
            const SizedBox(height: 20,),

            Center(
              child: BlocBuilder<RecipeViewBloc, RecipeViewState>(
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

                    List<RecipeModel> recipeList = [];

                    if(_selectedTab.toLowerCase() == 'popular'){
                      recipeList = state.allRecipeList;
                    } else{
                      recipeList = state.allRecipeList.where((recipe) => recipe.repast.toLowerCase() == _selectedTab.toLowerCase()).toList();
                    }

                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: recipeList.map((recipe){
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
                            SizedBox(
                              width: 170,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                recipe.dishName,
                                style: TextStyle(
                                    fontSize: FontSizeThemes.regularFont,
                                    color: ColorThemes.textPrimary,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(Icons.local_fire_department_rounded, color: Colors.deepOrange,size: 20,),
                                const SizedBox(width: 5,),
                                Text(
                                  '${recipe.cookingLevel} - ${recipe.repast}',
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
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

}
