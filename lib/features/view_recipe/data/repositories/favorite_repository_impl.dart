import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/core/failure.dart';
import 'package:recipe_finder_app/features/view_recipe/data/datasources/favorite_remote_datasource.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/favorite_model.dart';
import 'package:recipe_finder_app/features/view_recipe/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {

  FavoriteRemoteDatasource datasource;

  FavoriteRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<FavoriteModel>>> getFavoriteByUser(String userId) async{
    try{
      final favorites = await datasource.getFavoriteByUser(userId);
      return Right(favorites);
    } catch(e){
      return Left(QueryFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFavorite(FavoriteModel favorite) async{
    try{
      await datasource.delete(favorite);
      return Right('Success');
    } catch(e){
      return Left(QueryFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> insertFavorite(FavoriteModel favorite) async{
    try{
      await datasource.insert(favorite);
      return Right('Success');
    } catch(e){
      return Left(QueryFailure(e.toString()));
    }
  }

}