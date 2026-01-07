abstract class RecipeIngredientEntity {
  int id;
  int recipeId;
  int ingredientId;
  String amount;

  RecipeIngredientEntity({required this.id,required this.recipeId,required this.ingredientId,required this.amount});
}