import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../auth/data/models/user_model.dart';
import '../../data/models/recipe_model.dart';
import '../bloc/recipe_view_bloc.dart';
import '../pages/recipe_detail_page.dart';

class RecipeCardType3 extends StatelessWidget {
  const RecipeCardType3({super.key, required this.recipe, required this.user,});
  final RecipeModel recipe;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BlocProvider.value(
            value: context.read<RecipeViewBloc>(),
            child: RecipeDetailPage(recipe: recipe, user: user,),
          ))
      ),
      child: SizedBox(
        height: 200,
        width: 145,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(35),
                child: CachedNetworkImage(
                  imageUrl: recipe.imgUrl,
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
          ],
        ),
      ),
    );
  }
}
