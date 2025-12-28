import '../../domain/entities/step_entity.dart';

class StepModel extends StepEntity{
  StepModel({required super.id, required super.title, required super.instruction, required super.stepNumber});

  StepModel copyWith({int? id, String? title, String? instruction, int? stepNumber}){
    return StepModel(
        id: id ?? this.id,
        title: title ?? this.title,
        instruction: instruction ?? this.instruction,
        stepNumber: stepNumber ?? this.stepNumber
    );
  }

  factory StepModel.fromJson (Map<String, dynamic> json) {
    return StepModel(
        id: json['id'],
        title: json['title'],
        instruction: json['instruction'],
        stepNumber: json['step_number'],
    );
  }
}