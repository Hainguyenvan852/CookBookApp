class RecipeEntity {
  final int id;
  final String dishName;
  final String description;
  final int prepTime;
  final int cookingTime;
  final int serving;
  final String imgUrl;
  final DateTime createdAt;
  final String cookingLevel;
  final String repast;
  double? ratingSum;
  bool? isFavorite;

  RecipeEntity({
    required this.id,
    required this.dishName,
    required this.description,
    required this.prepTime,
    required this.cookingTime,
    required this.serving,
    required this.imgUrl,
    required this.createdAt,
    this.ratingSum,
    this.isFavorite,
    required this.cookingLevel,
    required this.repast,
  });
}