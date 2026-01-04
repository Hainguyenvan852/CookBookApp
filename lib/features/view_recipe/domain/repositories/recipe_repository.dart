import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/core/failure.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeModel>>> getAll(String userId);
}