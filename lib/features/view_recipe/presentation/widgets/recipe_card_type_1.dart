import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/pages/recipe_detail_page.dart';
import 'package:shimmer/shimmer.dart';

class RecipeCardType1 extends StatefulWidget {
  const RecipeCardType1({super.key, required this.recipe});
  final RecipeModel recipe;

  @override
  State<RecipeCardType1> createState() => _RecipeCardType1State();
}

class _RecipeCardType1State extends State<RecipeCardType1> {

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: widget.recipe))
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
                  imageUrl: widget.recipe.imgUrl,
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
                              '4.9',
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
                    widget.recipe.dishName,
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
                  '${widget.recipe.prepTime + widget.recipe.cookingTime} minutes',
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
                  'Easy',
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
