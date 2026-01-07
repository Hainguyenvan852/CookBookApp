import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/core/errors/failure.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/step_model.dart';

abstract class StepRepository {
  Future<Either<Failure, List<StepModel>>> getStep(int recipeId);
}