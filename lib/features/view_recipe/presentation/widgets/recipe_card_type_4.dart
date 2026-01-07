import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/data/models/user_model.dart';
import '../../data/models/recipe_model.dart';
import '../bloc/recipe_view/recipe_view_bloc.dart';
import '../pages/recipe_detail_page.dart';

class RecipeCardType4 extends StatelessWidget {
  const RecipeCardType4({super.key, required this.recipe, required this.onPressed, required this.user, required this.supabaseClient});
  final RecipeModel recipe;
  final VoidCallback onPressed;
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
      child: SizedBox(
        height: 240,
        width: 170,
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
            Positioned(
                right: 5,
                top: 5,
                child: IconButton(
                  onPressed: () => onPressed(),
                  icon: recipe.isFavorite! ? const Icon(Icons.favorite, color: Colors.pinkAccent, size: 20,) : const Icon(Icons.favorite, color: Colors.white, size: 20,),
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
