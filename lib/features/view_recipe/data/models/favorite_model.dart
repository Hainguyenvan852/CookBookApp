import 'package:recipe_finder_app/features/view_recipe/domain/entities/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity{
  FavoriteModel({
    required super.userId,
    required super.recipeId
  });

  FavoriteModel copyWith({String? userId, int? recipeId})
    => FavoriteModel(
      userId: userId ?? this.userId,
      recipeId: recipeId ?? this.recipeId
    );

  factory FavoriteModel.fromJson(Map<String, dynamic> json){
    return FavoriteModel(
      userId: json['user_id'],
      recipeId: json['recipe_id']
    );
  }
}