abstract class ReviewEntity {
  final int id;
  final String userId;
  final int recipeId;
  final int rating;
  final String? comment;

  ReviewEntity({
    required this.id,
    required this.userId,
    required this.recipeId,
    required this.rating,
    this.comment
  });
}