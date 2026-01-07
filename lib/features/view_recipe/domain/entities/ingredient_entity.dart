abstract class IngredientEntity {
  final int id;
  final String name;
  final String? amount;

  IngredientEntity({required this.id, required this.name, this.amount});
}