import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/step_model.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/pages/completed_cooking_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/models/recipe_model.dart';

class CookingModeScreen extends StatefulWidget {
  const CookingModeScreen({super.key, required this.recipe, required this.stepList,});
  final RecipeModel recipe;
  final List<StepModel> stepList;

  @override
  State<CookingModeScreen> createState() => _CookingModeScreenState();
}

class _CookingModeScreenState extends State<CookingModeScreen> {

  late StepModel currentStep;
  late int totalSteps;
  int currentIndex = 0;


  @override
  void initState() {
    super.initState();
    currentStep = widget.stepList[currentIndex];
    totalSteps = widget.stepList.length;
  }

  void _nextStep() {
    if (currentStep.stepNumber < totalSteps) {
      setState(() {
        currentIndex ++;
        currentStep = widget.stepList[currentIndex];
      });
    }
  }

  void _prevStep() {
    if (currentStep.stepNumber > 1) {
      setState(() {
        currentIndex --;
        currentStep = widget.stepList[currentIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),

          _buildContinuousStepIndicator(),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: 4,
                          sigmaY: 4
                        ),
                        child: CachedNetworkImage(
                          imageUrl:widget.recipe.imgUrl,
                          height: 250,
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
                        ),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.transparent
                              ],
                              stops: const [0.5, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: ColorThemes.cardBackground,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${currentIndex+1}",
                            style: TextStyle(
                              color: ColorThemes.primaryAccent,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 16),
                        Text(
                          currentStep.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        Text(
                          currentStep.instruction,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),

                        _buildSmartCookingCard(),

                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          color: ColorThemes.backgroundColor,
                          child: Row(
                            children: [
                              if(currentIndex != 0)
                                Expanded(
                                  flex: 1,
                                  child: OutlinedButton(
                                    onPressed: _prevStep,
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.white.withOpacity(0.2)),
                                      padding: const EdgeInsets.symmetric(vertical: 18),
                                      minimumSize: Size(double.infinity, 60),
                                      maximumSize: Size(double.infinity, 60),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.arrow_back, size: 18, color: Colors.grey),
                                        const SizedBox(width: 8),
                                        Text("Previous", style: TextStyle(color: Colors.white.withOpacity(0.8))),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 15),
                              if(currentIndex+1 == totalSteps)
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CompletionScreen(recipe: widget.recipe))),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorThemes.primaryAccent,
                                      foregroundColor: Colors.black,
                                      minimumSize: Size(double.infinity, 60),
                                      maximumSize: Size(double.infinity, 60),
                                      padding: const EdgeInsets.symmetric(vertical: 18),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                          Text(
                                              "Done",
                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                                          ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_forward, size: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              if(currentIndex+1 != totalSteps)
                                Expanded(
                                  flex: 2,
                                  child: ElevatedButton(
                                    onPressed: () => _nextStep(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorThemes.primaryAccent,
                                      foregroundColor: Colors.black,
                                      minimumSize: Size(double.infinity, 60),
                                      maximumSize: Size(double.infinity, 60),
                                      padding: const EdgeInsets.symmetric(vertical: 18),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "Next Step",
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_forward, size: 20),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
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
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 105,),
          Column(
            children: [
              Text(
                "COOKING MODE",
                style: TextStyle(color: ColorThemes.primaryAccent, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
              const SizedBox(height: 2),
              Text(
                "Step ${currentIndex + 1} of $totalSteps",
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          // IconButton(
          //   icon: const Icon(Icons.list, color: Colors.white),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }


  Widget _buildContinuousStepIndicator() {
    double percent = (currentIndex+1) / totalSteps;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        height: 4,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: constraints.maxWidth * percent,
                  decoration: BoxDecoration(
                    color: ColorThemes.primaryAccent,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: ColorThemes.primaryAccent.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartCookingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorThemes.cardBackground,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF43D17C),
            Color(0xFF162921)
          ],
          stops: [0, 0.7]
        )
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 130, height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorThemes.primaryAccent.withOpacity(0.4), width: 1),
                ),
              ),
              Container(
                width: 90, height: 90,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    boxShadow: [
                      BoxShadow(color: ColorThemes.primaryAccent.withOpacity(0.4), blurRadius: 20, spreadRadius: 2)
                    ]
                ),
                child: Icon(Icons.soup_kitchen, color: ColorThemes.primaryAccent, size: 34),
              ),
              Positioned(
                top: 10, right: 10,
                child: Icon(Icons.local_fire_department, color: Colors.orange, size: 18),
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}