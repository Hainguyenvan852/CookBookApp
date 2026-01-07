import 'package:recipe_finder_app/features/view_recipe/domain/entities/recipe_ingredient_entity.dart';

class RecipeIngredientModel extends RecipeIngredientEntity{
  RecipeIngredientModel({required super.id, required super.recipeId, required super.ingredientId, required super.amount});

  RecipeIngredientModel copyWith({int? id, int? recipeId, int? ingredientId, String? amount,}){
    return RecipeIngredientModel(
        id: id ?? this.id,
        ingredientId: ingredientId ?? this.ingredientId,
        recipeId: recipeId ?? this.recipeId,
        amount: amount ?? this.amount,
    );
  }

  factory RecipeIngredientModel.fromJson (Map<String, dynamic> json) {
    return RecipeIngredientModel(
      id: json['id'],
      ingredientId: json['ingredient_id'],
      recipeId: json['recipe_id'],
      amount: json['amount'],
    );
  }
}