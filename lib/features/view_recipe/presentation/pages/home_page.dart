import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/bloc/recipe_view/recipe_view_bloc.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/pages/notification_page.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/pages/skeleton_loading_page.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/widgets/recipe_card_type_1.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../bloc/recipe_view/recipe_view_state.dart';
import '../widgets/recipe_card_type_2.dart';
import '../widgets/recipe_card_type_3.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user, required this.supabaseClient});
  final UserModel user;
  final SupabaseClient supabaseClient;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeViewBloc, RecipeViewState>(
        builder: (context, state){
          if(state.isLoading){
            return HomeShimmer();
          }

          if(state.error != null){
            return SizedBox(
              height: 400,
              child: Center(
                child: Text(state.error!),
              ),
            );
          }
          return Scaffold(
            body:CustomScrollView(
              slivers: [
                _buildAppBar(),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Builder(
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTodayList(recipeList: state.allRecipeList.take(5).toList()),
                                SizedBox(height: 40,),
                                _buildFeaturedList(recipeList: state.todayRecipeList),
                                SizedBox(height: 40,),
                                _buildNewlyList(recipeList: state.newlyRecipeList),
                                SizedBox(height: 30,),
                                Text(
                                  'Daily cooking tips',
                                  style: TextStyle(
                                      color: ColorThemes.textPrimary,
                                      fontSize: FontSizeThemes.mediumFont,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 10,),
                                ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    _buildTip(title: 'Keep vegetables fresh longer', content: 'Wrap the vegetables in damp paper and wrap them in an airtight container to keep them fresh all week.'),
                                    const SizedBox(height: 10,),
                                    _buildTip(title: 'Clear broth', content: 'Boil over low heat and skim the foam frequently for the perfect pot of water.')
                                  ],
                                ),
                              ],
                            );
                          }
                      )
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  Widget _buildAppBar(){
    return SliverAppBar(
      toolbarHeight: 70,
      floating: true,
      snap: true,
      pinned: false,
      title: RichText(
          text: TextSpan(
              text: 'Good morning,',
              style: TextStyle(
                  color: ColorThemes.textSecondary,
                  fontSize: FontSizeThemes.regularFont
              ),
              children: [
                TextSpan(
                    text: '\nChef ${widget.user.name}!',
                    style: TextStyle(
                        color: ColorThemes.textPrimary,
                        fontSize: FontSizeThemes.mediumFont,
                        fontWeight: FontWeight.bold
                    )
                )
              ]
          )
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage())),
          icon: Icon(Icons.notifications_rounded, color: ColorThemes.primaryAccent, size: 22,),
          style: IconButton.styleFrom(
              backgroundColor: ColorThemes.iconBackground
          ),
        )
      ],
    );
  }

  Widget _buildTodayList({
    required List<RecipeModel> recipeList
  }){
    return (recipeList.isNotEmpty) ? Wrap(
      runSpacing: 10,
      children: [
        Text(
          'Today\'s dish',
          style: TextStyle(
              color: ColorThemes.textPrimary,
              fontSize: FontSizeThemes.mediumFont,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 250,
          child: (recipeList.isNotEmpty) ? ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return RecipeCardType1(recipe: recipeList[index], user: widget.user, supabaseClient: widget.supabaseClient,);
              },
              separatorBuilder: (context, index){
                return const SizedBox(width: 15,);
              },
              itemCount: recipeList.length
          ) : SizedBox(
            height: 250,
          ),
        ),
      ],
    ) : Wrap(
      runSpacing: 10,
      children: [
        Text(
          'Today\'s dish',
          style: TextStyle(
              color: ColorThemes.textPrimary,
              fontSize: FontSizeThemes.mediumFont,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(
          height: 250,
        )
      ],
    );
  }

  Widget _buildFeaturedList({
    required List<RecipeModel> recipeList
  }){
    return (recipeList.isNotEmpty) ? Wrap(
      runSpacing: 20,
      children: [
        RichText(
            text: TextSpan(
                text: 'Featured recipes',
                style: TextStyle(
                    color: ColorThemes.textPrimary,
                    fontSize: FontSizeThemes.mediumFont,
                    fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: '\nBuilt by top chefs',
                    style: TextStyle(
                        color: ColorThemes.textSecondary,
                        fontSize: FontSizeThemes.smallFont,
                        fontWeight: FontWeight.w400
                    ),
                  )
                ]
            )
        ),
        SizedBox(height: 20,),
        SizedBox(
          height: 270,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecipeCardType3(
                      recipe: recipeList[index],
                      user: widget.user,
                      supabaseClient: widget.supabaseClient,
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      width: 120,
                      child: Text(
                        maxLines: 2,
                        recipeList[index].dishName,
                        style: TextStyle(
                            fontSize: FontSizeThemes.regularFont,
                            color: ColorThemes.textPrimary,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      '${recipeList[index].prepTime + recipeList[index].cookingTime} minutes - ${recipeList[index].cookingLevel}',
                      style: TextStyle(
                        fontSize: FontSizeThemes.smallFont,
                        color: ColorThemes.textSecondary,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index){
                return const SizedBox(width: 15,);
              },
              itemCount: recipeList.length
          ),
        ),
      ],
    ) : Wrap(
      runSpacing: 20,
      children: [
        RichText(
            text: TextSpan(
                text: 'Featured recipes',
                style: TextStyle(
                    color: ColorThemes.textPrimary,
                    fontSize: FontSizeThemes.mediumFont,
                    fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: '\nBuilt by top chefs',
                    style: TextStyle(
                        color: ColorThemes.textSecondary,
                        fontSize: FontSizeThemes.smallFont,
                        fontWeight: FontWeight.w400
                    ),
                  )
                ]
            )
        ),
        SizedBox(height: 20,),
        SizedBox(
          height: 270,
        ),
      ],
    );
  }

  Widget _buildNewlyList({
    required List<RecipeModel> recipeList
  }){
    return (recipeList.isNotEmpty) ? Wrap(
      runSpacing: 20,
      children: [
        Text(
          'Newly update',
          style: TextStyle(
              color: ColorThemes.textPrimary,
              fontSize: FontSizeThemes.mediumFont,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return RecipeCardType2(
                recipe: recipeList[index],
                user: widget.user,
                supabaseClient: widget.supabaseClient,
              );
            },
            separatorBuilder: (context, index){
              return const SizedBox(height: 15,);
            },
            itemCount: 4
        ),
      ],
    ) : Wrap(
      runSpacing: 20,
      children: [
        Text(
          'Newly update',
          style: TextStyle(
              color: ColorThemes.textPrimary,
              fontSize: FontSizeThemes.mediumFont,
              fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        SizedBox(
          height: 110,
        )
      ],
    );
  }

  Widget _buildTip
  ({
    required String title,
    required String content
  }){
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          color: ColorThemes.cardBackground
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0F542E)
            ),
            child: Icon(Icons.tips_and_updates, color: ColorThemes.primaryAccent, size: 28,),
          ),
          SizedBox(width: 15,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: ColorThemes.textPrimary,
                    fontSize: FontSizeThemes.regularFont,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                width: 280,
                child: Text(
                  overflow: TextOverflow.clip,
                  content,
                  style: TextStyle(
                    color: ColorThemes.textSecondary,
                    fontSize: FontSizeThemes.regularFont,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
