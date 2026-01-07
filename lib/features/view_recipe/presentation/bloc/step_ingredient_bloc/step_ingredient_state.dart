import 'package:recipe_finder_app/features/view_recipe/data/models/ingredient_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/step_model.dart';

class StepIngredientState {
  List<StepModel> steps;
  List<IngredientModel> ingredients;
  String? error;
  bool isLoading;

  StepIngredientState({required this.steps, required this.ingredients, required this.isLoading, this.error});

  factory StepIngredientState.initial() => StepIngredientState(
      isLoading: true,
      ingredients: [],
      steps: [],
  );

  StepIngredientState copyWith({
    bool? isLoading,
    List<StepModel>? steps,
    List<IngredientModel>? ingredients,
    String? error,
  }) => StepIngredientState(
    isLoading: isLoading ?? this.isLoading,
    steps: steps ?? this.steps,
    ingredients: ingredients ?? this.ingredients,
    error: error ?? this.error,
  );
}