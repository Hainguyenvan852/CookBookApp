import 'package:recipe_finder_app/features/view_recipe/domain/entities/ingredient_entity.dart';

class IngredientModel extends IngredientEntity{
  IngredientModel({required super.id, required super.name, super.amount,});

  IngredientModel copyWith({int? id, String? name, String? amount}){
    return IngredientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount
    );
  }

  factory IngredientModel.fromJson (Map<String, dynamic> json) {
    return IngredientModel(
      id: json['id'],
      name: json['name'],
    );
  }
}