class RecipeEntity {
  final int id;
  final String dishName;
  final String description;
  final int prepTime;
  final int cookingTime;
  final int serving;
  final String imgUrl;

  RecipeEntity({
    required this.id,
    required this.dishName,
    required this.description,
    required this.prepTime,
    required this.cookingTime,
    required this.serving,
    required this.imgUrl
  });
}