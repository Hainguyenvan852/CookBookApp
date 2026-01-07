import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/core/errors/failure.dart';
import 'package:recipe_finder_app/features/view_recipe/data/datasources/recipe_ingredient_remote_datasource.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_ingredient_model.dart';
import 'package:recipe_finder_app/features/view_recipe/domain/repositories/recipe_ingredient_repository.dart';

class RecipeIngredientRepositoryImpl extends RecipeIngredientRepository{

  RecipeIngredientRemoteDatasource datasource;
  RecipeIngredientRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<RecipeIngredientModel>>> getList(int recipeId) async {
    try{
      final ingredients = await datasource.get(recipeId);
      return Right(ingredients);
    } catch(e){
      return Left(QueryFailure(e.toString()));
    }
  }
}