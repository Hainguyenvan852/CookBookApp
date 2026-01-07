import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/core/errors/failure.dart';
import 'package:recipe_finder_app/features/view_recipe/data/datasources/ingredient_remote_datasource.dart';
import 'package:recipe_finder_app/features/view_recipe/data/datasources/recipe_ingredient_remote_datasource.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/ingredient_model.dart';
import 'package:recipe_finder_app/features/view_recipe/domain/repositories/ingredient_repository.dart';

class IngredientRepositoryImpl extends IngredientRepository{

  final IngredientRemoteDatasource ingredientRemoteDatasource;
  final RecipeIngredientRemoteDatasource recipeIngredientRemoteDatasource;

  IngredientRepositoryImpl({required this.ingredientRemoteDatasource, required this.recipeIngredientRemoteDatasource, });

  @override
  Future<Either<Failure, List<IngredientModel>>> getIngredient(int recipeId) async {
    try{
      List<IngredientModel> ingredients = [];

      final result = await recipeIngredientRemoteDatasource.get(recipeId);

      if(result.isNotEmpty){
        for(var i in result){
          var ingredient = await ingredientRemoteDatasource.get(i.ingredientId);

          ingredient = ingredient.copyWith(amount: i.amount);

          ingredients.add(ingredient);
        }
      }

      return Right(ingredients);
    } catch(e){
      return Left(QueryFailure(e.toString()));
    }
  }
}