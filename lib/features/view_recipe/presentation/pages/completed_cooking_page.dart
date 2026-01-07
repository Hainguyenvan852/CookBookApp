import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/recipe_model.dart';


class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key, required this.recipe});
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Colors.transparent],
                                stops: [0.6, 1.0],
                              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: CachedNetworkImage(
                              imageUrl: recipe.imgUrl,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
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
                            )
                          ),
                        ),

                        Container(
                          width: 90, height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorThemes.primaryAccent,
                            boxShadow: [
                              BoxShadow(
                                color: ColorThemes.primaryAccent.withOpacity(0.2),
                                blurRadius: 5,
                                spreadRadius: 5,
                              )
                            ],
                            border: Border.all(color: ColorThemes.backgroundColor, width: 4),
                          ),
                          child: const Icon(Icons.check, color: Colors.black, size: 40),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Bon Appétit!",
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "You've successfully completed",
                      style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Traditional Beef Pho",
                      style: TextStyle(color: ColorThemes.primaryAccent, fontSize: 16, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatChip(Icons.schedule, "${recipe.prepTime + recipe.cookingTime} min", ColorThemes.cardBackground, ColorThemes.primaryAccent),
                        const SizedBox(width: 15),
                        _buildStatChip(Icons.local_fire_department, "Excellent", ColorThemes.cardBackground, Colors.orangeAccent),
                      ],
                    ),

                    const SizedBox(height: 30),

                    StarRatingCard(),

                    const SizedBox(height: 20),

                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ColorThemes.cardBackground,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            maxLines: null,
                            minLines: 5,
                            decoration: InputDecoration(
                              hintText: "Write your review",
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            onTapOutside: (event){

                            },
                          ),
                          const SizedBox(height: 10),
                          // GestureDetector(
                          //   onTap: (){},
                          //   child: Icon(Icons.camera_alt_outlined, color: Colors.white.withOpacity(0.6), size: 20),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_){
                                    return AlertDialog(
                                      title: Text('Your review has sent', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                                      iconPadding: EdgeInsets.only(top: 60, bottom: 20),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () => Navigator.pop(context),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(double.infinity, 40),
                                              maximumSize: Size(double.infinity, 40),
                                            ),
                                            child: Text('OK')
                                        )
                                      ],
                                      actionsAlignment: MainAxisAlignment.center,
                                      backgroundColor: ColorThemes.backgroundColor,
                                      icon: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorThemes.primaryAccent.withOpacity(0.2),
                                        ),
                                        child: Icon(Icons.check_circle, color: ColorThemes.primaryAccent, size: 25,),
                                      ),
                                    );
                                  }
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.white.withOpacity(0.2)),
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: const Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: ()=> Navigator.popUntil(context, (route) => route.isFirst),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorThemes.primaryAccent,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String text, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class StarRatingCard extends StatefulWidget {
  const StarRatingCard({super.key});

  @override
  State<StarRatingCard> createState() => _StarRatingCardState();
}

class _StarRatingCardState extends State<StarRatingCard> {

  int starCount = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorThemes.cardBackground,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const Text("Rate this recipe", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      starCount = 1;
                    });
                  },
                  child: Icon(
                    Icons.star,
                    color: (starCount >= 1) ? Colors.yellow : Colors.white.withOpacity(0.2),
                    size: 40,
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      starCount = 2;
                    });
                  },
                  child: Icon(
                    Icons.star,
                    color: (starCount >= 2) ? Colors.yellow : Colors.white.withOpacity(0.2),
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      starCount = 3;
                    });
                  },
                  child: Icon(
                    Icons.star,
                    color: (starCount >= 3) ? Colors.yellow : Colors.white.withOpacity(0.2),
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      starCount = 4;
                    });
                  },
                  child: Icon(
                    Icons.star,
                    color: (starCount >= 4) ? Colors.yellow : Colors.white.withOpacity(0.2),
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      starCount = 5;
                    });
                  },
                  child: Icon(
                    Icons.star,
                    color: (starCount == 5) ? Colors.yellow : Colors.white.withOpacity(0.2),
                    size: 40,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

