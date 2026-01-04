import 'package:recipe_finder_app/features/view_recipe/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({required super.id, required super.userId, required super.recipeId, required super.rating, super.comment});

  ReviewModel copyWith({int? id, String? userId, int? recipeId, int? rating, String? comment}){
    return ReviewModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        recipeId: recipeId ?? this.recipeId,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
    );
  }

  factory ReviewModel.fromJson (Map<String, dynamic> json) {
    return ReviewModel(
        id: json['id'],
        userId: json['user_id'],
        recipeId: json['recipe_id'],
        rating: json['rating'],
        comment: json['comment'] as String?,
    );
  }
}