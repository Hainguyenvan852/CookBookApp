import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_ingredient_model.dart';

import '../../../../core/errors/failure.dart';

abstract class RecipeIngredientRepository {
  Future<Either<Failure, List<RecipeIngredientModel>>> getList(int recipeId);
}