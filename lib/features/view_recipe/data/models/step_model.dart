import '../../domain/entities/step_entity.dart';

class StepModel extends StepEntity{
  StepModel({required super.id, required super.title, required super.instruction, required super.stepNumber, required super.recipeId});

  StepModel copyWith({int? id, String? title, String? instruction, int? stepNumber, int? recipeId}){
    return StepModel(
        id: id ?? this.id,
        title: title ?? this.title,
        instruction: instruction ?? this.instruction,
        stepNumber: stepNumber ?? this.stepNumber,
        recipeId: recipeId ?? this.recipeId
    );
  }

  factory StepModel.fromJson (Map<String, dynamic> json) {
    return StepModel(
      id: json['id'],
      title: json['title'],
      instruction: json['instruction'],
      stepNumber: json['step_number'],
      recipeId: json['recipe_id'],
    );
  }
}