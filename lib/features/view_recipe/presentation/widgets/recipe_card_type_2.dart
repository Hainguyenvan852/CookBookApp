import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/recipe_model.dart';
import '../pages/recipe_detail_page.dart';

class RecipeCardType2 extends StatelessWidget {
  const RecipeCardType2({super.key, required this.recipe});
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: recipe))
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 110,
        decoration: BoxDecoration(
          color: ColorThemes.iconBackground,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: CachedNetworkImage(
                imageUrl: recipe.imgUrl,
                errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.white,)),
                placeholder: (context, url){
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      height: 90,
                      color: Colors.white,
                    ),
                  );
                },
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              )
            ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  recipe.dishName,
                  style: TextStyle(
                    color: ColorThemes.textPrimary,
                    fontSize: FontSizeThemes.mediumFont,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width: 200,
                  child: Text(
                    recipe.description,
                    style: TextStyle(
                      color: ColorThemes.iconColor2,
                      fontSize: FontSizeThemes.regularFont,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.timer, color: ColorThemes.iconColor1, size: 18,),
                    SizedBox(width: 5,),
                    Text(
                      '${recipe.prepTime + recipe.cookingTime}m',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizeThemes.regularFont,
                          color: ColorThemes.iconColor1
                      ),
                    ),
                    SizedBox(width: 20,),
                    Icon(Icons.star, color: ColorThemes.iconColor1, size: 18,),
                    Text(
                      '4.9',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: FontSizeThemes.smallFont,
                          color: ColorThemes.iconColor1
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ),
    );
  }
}
