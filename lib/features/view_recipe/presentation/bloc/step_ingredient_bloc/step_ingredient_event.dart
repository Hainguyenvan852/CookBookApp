abstract class StepIngredientEvent {}

class LoadStepAndIngredient extends StepIngredientEvent{
  int recipeId;

  LoadStepAndIngredient({required this.recipeId,});
}