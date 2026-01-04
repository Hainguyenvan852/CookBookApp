import 'package:recipe_finder_app/features/view_recipe/data/models/favorite_model.dart';

abstract class RecipeViewEvent {}

class LoadRecipe extends RecipeViewEvent{}

class FavoritePressed extends RecipeViewEvent{
  final FavoriteModel favoriteModel;
  FavoritePressed({required this.favoriteModel});
}

class NoFavoritePressed extends RecipeViewEvent{
  final FavoriteModel favoriteModel;
  NoFavoritePressed({required this.favoriteModel});
}