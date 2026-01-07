import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/pages/recipe_detail_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../bloc/recipe_view/recipe_view_bloc.dart';

class RecipeCardType1 extends StatelessWidget {
  const RecipeCardType1({super.key, required this.recipe, required this.user, required this.supabaseClient});
  final RecipeModel recipe;
  final UserModel user;
  final SupabaseClient supabaseClient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BlocProvider.value(
            value: context.read<RecipeViewBloc>(),
            child: RecipeDetailPage(recipe: recipe, user: user, supabaseClient: supabaseClient,),
          ))
      ),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(25),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.black
                      ],
                      stops: [0.4, 1]
                  ).createShader(bounds);
                },
                child: CachedNetworkImage(
                  imageUrl: recipe.imgUrl,
                  errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.white,)),
                  placeholder: (context, url){
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        color: Colors.white,
                      ),
                    );
                  },
                  height: 250,
                  width: 300,
                  fit: BoxFit.cover,
                )
              ),
          ),
          Positioned(
            width: 280,
            left: 10,
            top: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: ColorThemes.primaryAccent,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text('TRENDING', style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizeThemes.smallFont),),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16,),
                            Text(
                              recipe.ratingSum.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSizeThemes.smallFont,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    recipe.dishName,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: FontSizeThemes.bigTitleFont,
                      color: ColorThemes.textPrimary,
                      fontWeight: FontWeight.bold,
                      height: 1
                    ),
                  ),

                ],
              )
          ),
          Positioned(
            left: 10,
            top: 210,
            child: Row(
              children: [
                Icon(Icons.access_time_filled_rounded, color: Colors.white, size: 20,),
                SizedBox(width: 5,),
                Text(
                  '${recipe.prepTime + recipe.cookingTime} minutes',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizeThemes.regularFont,
                      color: ColorThemes.textPrimary
                  ),
                ),
                SizedBox(width: 20,),
                Icon(Icons.local_fire_department, color: Colors.white, size: 20,),
                SizedBox(width: 5,),
                Text(
                  recipe.cookingLevel,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizeThemes.regularFont,
                      color: ColorThemes.textPrimary
                  ),
                ),
              ],
            )
          )
        ]
      ),
    );
  }
}
