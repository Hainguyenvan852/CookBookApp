import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/core/failure.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/favorite_model.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, List<FavoriteModel>>> getFavoriteByUser(String userId);
  Future<Either<Failure, String>> deleteFavorite(FavoriteModel favorite);
  Future<Either<Failure, String>> insertFavorite(FavoriteModel favorite);
}