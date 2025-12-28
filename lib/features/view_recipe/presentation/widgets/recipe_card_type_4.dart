import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/recipe_model.dart';
import '../pages/recipe_detail_page.dart';

class RecipeCardType4 extends StatefulWidget {
  const RecipeCardType4({super.key, required this.recipe});
  final RecipeModel recipe;

  @override
  State<RecipeCardType4> createState() => _StateProductCardType4();
}

class _StateProductCardType4 extends State<RecipeCardType4> {

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecipeDetailPage(recipe: widget.recipe))
      ),
      child: SizedBox(
        height: 240,
        width: 170,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(35),
                child: CachedNetworkImage(
                  imageUrl: widget.recipe.imgUrl,
                  placeholder: (context, url) =>
                      Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 100,
                            color: Colors.white,
                          )
                      ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                right: 5,
                top: 5,
                child: IconButton(
                  onPressed: (){
                    setState(() {
                      isFavorite = isFavorite ? false : true;
                    });
                  },
                  icon: isFavorite ? Icon(Icons.favorite, color: Colors.pinkAccent, size: 20,) : Icon(Icons.favorite, color: Colors.white, size: 20,),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.black38,
                      minimumSize: Size(30, 30),
                      maximumSize: Size(40, 40)
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
