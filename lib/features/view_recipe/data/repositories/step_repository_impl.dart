import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/core/errors/failure.dart';
import 'package:recipe_finder_app/features/view_recipe/data/datasources/step_remote_datasource.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/step_model.dart';
import 'package:recipe_finder_app/features/view_recipe/domain/repositories/step_repository.dart';

class StepRepositoryImpl extends StepRepository{

  final StepRemoteDatasource datasource;

  StepRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<StepModel>>> getStep(int recipeId) async{
    try{
      final steps = await datasource.get(recipeId);
      return Right(steps);
    } catch(e){
      return Left(QueryFailure(e.toString()));
    }
  }

}