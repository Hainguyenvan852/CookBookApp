import '../../domain/entities/recipe_entity.dart';

class RecipeModel extends RecipeEntity{
  RecipeModel({
    required super.id,
    required super.dishName,
    required super.description,
    required super.prepTime,
    required super.cookingTime,
    required super.serving,
    required super.imgUrl
  });

  RecipeModel copyWith({int? id, String? dishName, String? description, int? prepTime, int? cookingTime, int? serving, String? imgUrl}){
    return RecipeModel(
        id: id ?? this.id,
        dishName: dishName ?? this.dishName,
        description: description ?? this.description,
        prepTime: prepTime ?? this.prepTime,
        cookingTime: cookingTime ?? this.cookingTime,
        serving: serving ?? this.serving,
        imgUrl: imgUrl ?? this.imgUrl
    );
  }

  factory RecipeModel.fromJson (Map<String, dynamic> json) {
    return RecipeModel(
        id: json['id'],
        dishName: json['dish_name'],
        description: json['description'],
        prepTime: json['prep_time'],
        cookingTime: json['cooking_time'],
        serving: json['servings'],
        imgUrl: json['image_url']
    );
  }
}