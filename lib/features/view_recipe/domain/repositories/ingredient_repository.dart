import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/ingredient_model.dart';

import '../../../../core/errors/failure.dart';

abstract class IngredientRepository {
  Future<Either<Failure, List<IngredientModel>>> getIngredient(int recipeId);
}