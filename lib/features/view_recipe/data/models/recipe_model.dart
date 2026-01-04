import 'package:recipe_finder_app/features/view_recipe/domain/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity{
  RecipeModel({
    required super.id,
    required super.dishName,
    required super.description,
    required super.prepTime,
    required super.cookingTime,
    required super.serving,
    required super.imgUrl,
    required super.createdAt,
    required super.cookingLevel,
    required super.repast,
    super.isFavorite,
    super.ratingSum
  });

  RecipeModel copyWith({int? id, String? dishName, String? description, int? prepTime, int? cookingTime, int? serving, String? imgUrl, double? ratingSum, String? cookingLevel, String? repast, DateTime? createdAt, bool? isFavorite}){
    return RecipeModel(
        id: id ?? this.id,
        dishName: dishName ?? this.dishName,
        description: description ?? this.description,
        prepTime: prepTime ?? this.prepTime,
        cookingTime: cookingTime ?? this.cookingTime,
        serving: serving ?? this.serving,
        imgUrl: imgUrl ?? this.imgUrl,
        ratingSum: ratingSum ?? this.ratingSum,
        createdAt: createdAt ?? this.createdAt,
        cookingLevel: cookingLevel ?? this.cookingLevel,
        repast: repast ?? this.repast,
        isFavorite: isFavorite ?? this.isFavorite
    );
  }

  factory RecipeModel.fromJson (Map<String, dynamic> json) {

    DateTime dateTimeUtc = DateTime.parse(json['created_at']);
    DateTime dateTimeLocal = dateTimeUtc.toLocal();

    return RecipeModel(
        id: json['id'],
        dishName: json['dish_name'],
        description: json['description'],
        prepTime: json['prep_time'],
        cookingTime: json['cooking_time'],
        serving: json['servings'],
        imgUrl: json['image_url'],
        createdAt: dateTimeLocal,
        cookingLevel: json['cooking_level'],
        repast: json['repast']
    );
  }
}