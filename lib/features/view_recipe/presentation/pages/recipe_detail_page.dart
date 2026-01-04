import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/pages/preparation_step_page.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';

import '../../data/models/favorite_model.dart';
import '../bloc/recipe_view_bloc.dart';
import '../bloc/recipe_view_event.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({super.key, required this.recipe, required this.user});
  final RecipeModel recipe;
  final UserModel user;

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late bool isFavorite;


  @override
  void initState() {
    super.initState();
    isFavorite = widget.recipe.isFavorite!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 350,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.transparent
                          ],
                          stops: [0.8, 1]
                      ).createShader(bounds);
                    },
                    child: CachedNetworkImage(
                      imageUrl: widget.recipe.imgUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          ColorThemes.backgroundColor,
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.6],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: CircleAvatar(
                      backgroundColor: Colors.black38,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 23,),
                        onPressed: () => Navigator.pop(context),
                      ),
                    )
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: Wrap(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black38,
                          child: IconButton(
                            icon: const Icon(Icons.share, color: Colors.white),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.black38,
                          child: IconButton(
                            icon: isFavorite ? const Icon(Icons.favorite, color: Colors.pinkAccent) : const Icon(Icons.favorite, color: Colors.white),
                            onPressed: (){
                              if(isFavorite){
                                setState(() {
                                  isFavorite = false;
                                });
                                final favorite = FavoriteModel(userId: widget.user.id, recipeId: widget.recipe.id);
                                context.read<RecipeViewBloc>().add(NoFavoritePressed(favoriteModel: favorite));
                              }else{
                                setState(() {
                                  isFavorite = true;
                                });
                                final favorite = FavoriteModel(userId: widget.user.id, recipeId: widget.recipe.id);
                                context.read<RecipeViewBloc>().add(FavoritePressed(favoriteModel: favorite));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _buildTag("DINNER", Colors.green.withOpacity(0.5), ColorThemes.primaryAccent),
                            const SizedBox(width: 8),
                            _buildTag("Vietnamese", Colors.black38, Colors.white),
                            const SizedBox(width: 8),
                            _buildTag("Healthy", Colors.black38, Colors.white),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.recipe.dishName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.recipe.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRecipeStats(),
                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Ingredients", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("6 items", style: TextStyle(color: Colors.white.withOpacity(0.5))),
                    ],
                  ),
                  const SizedBox(height: 15),

                  _buildIngredientItem("Rice Noodles", "500g, flat dry style", ColorThemes.cardBackground),
                  _buildIngredientItem("Beef Sirloin", "200g, thinly sliced", ColorThemes.cardBackground),
                  _buildIngredientItem("White Onion", "1 large, sliced", ColorThemes.cardBackground),
                  _buildIngredientItem("Fresh Ginger", "3 inch piece, charred", ColorThemes.cardBackground),

                  const SizedBox(height: 30),
                  const Text("Instructions", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  _buildInstructionStep(
                    step: "1",
                    title: "Prepare the Broth",
                    description: "Char the onion and ginger over an open flame until blackened. Simmer beef bones...",
                    cardColor: ColorThemes.cardBackground,
                    accentColor: ColorThemes.primaryAccent,
                    isLast: false,
                  ),
                  _buildInstructionStep(
                    step: "2",
                    title: "Blanch Noodles",
                    description: "Boil the rice noodles according to package instructions until al dente...",
                    cardColor: ColorThemes.cardBackground,
                    accentColor: ColorThemes.primaryAccent,
                    isLast: false,
                  ),
                  _buildInstructionStep(
                    step: "3",
                    title: "Assemble & Serve",
                    description: "Place noodles in a bowl, top with raw beef slices. Pour boiling hot broth directly...",
                    cardColor: ColorThemes.cardBackground,
                    accentColor: ColorThemes.primaryAccent,
                    isLast: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => PreparationScreen(recipe: widget.recipe,))
                      ),
                      icon: Icon(Icons.play_arrow_rounded, color: Colors.black, size: 24,),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 55),
                        maximumSize: Size(double.infinity, 60)
                      ),
                      label: Text(
                        'Start Cooking',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: FontSizeThemes.mediumFont,
                          fontWeight: FontWeight.bold
                        ),
                      )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color backGroundColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildRecipeStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF162921),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(icon: Icons.access_time_filled_rounded, value: "${widget.recipe.prepTime} min", label: "PREP"),
          Container(
            height: 80,
            width: 0.5,
            color: ColorThemes.iconColor1,
          ),
          _StatItem(icon: Icons.local_fire_department, value: "${widget.recipe.cookingTime} min", label: "COOK"),
          Container(
            height: 80,
            width: 0.5,
            color: ColorThemes.iconColor1,
          ),
          _StatItem(icon: Icons.people, value: "${widget.recipe.serving} Ppl", label: "SERVES"),
        ],
      ),
    );
  }

  Widget _buildIngredientItem(String name, String detail, Color bgColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.shopping_basket, color: ColorThemes.primaryAccent, size: 20),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              Text(detail, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInstructionStep({
    required String step,
    required String title,
    required String description,
    required Color cardColor,
    required Color accentColor,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 30, height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF1F352A),
                  border: Border.all(color: Colors.transparent),
                ),
                child: Center(
                  child: Text(step, style: TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFF1F352A),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(description, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, height: 1.4)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.green, size: 22),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}

