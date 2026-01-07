import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/core/errors/failure.dart';
import 'package:recipe_finder_app/features/view_recipe/data/datasources/recipe_remote_datasource.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';
import 'package:recipe_finder_app/features/view_recipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryIpml extends RecipeRepository {
  RecipeRemoteDataSource datasource;

  RecipeRepositoryIpml({required this.datasource});

  @override
  Future<Either<Failure, List<RecipeModel>>> getAll(String userId) async{
    try{
      final result = await datasource.getRecipeByRating(userId);
      return Right(result);
    } catch(e){
      return Left(QueryFailure(e.toString()));
    }
  }
}