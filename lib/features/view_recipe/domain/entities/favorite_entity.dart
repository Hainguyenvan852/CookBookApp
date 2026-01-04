abstract class FavoriteEntity {
  final int recipeId;
  final String userId;

  FavoriteEntity({
    required this.userId,
    required this.recipeId
  });
}