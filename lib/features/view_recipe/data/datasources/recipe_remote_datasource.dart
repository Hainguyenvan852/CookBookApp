import 'package:recipe_finder_app/features/view_recipe/data/datasources/favorite_remote_datasource.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/favorite_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/review_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeRemoteDataSource {
  final SupabaseClient supabaseClient;
  final FavoriteRemoteDatasource favoriteDatasource;
  RecipeRemoteDataSource({required this.supabaseClient, required this.favoriteDatasource});

  Future<List<RecipeModel>> getAll() async {
    final query = await supabaseClient.from('Recipes')
        .select('id, dish_name, description, prep_time, cooking_time, servings, image_url, is_active, created_at, cooking_level, repast')
        .eq('is_active', true);

    return query.map((json) => RecipeModel.fromJson(json)).toList();
  }

  Future<List<RecipeModel>> getRecipeByRating(String userId) async {
    final recipes = await getAll();
    List<RecipeModel> listByRating = [];

    if(recipes.isNotEmpty){
      for(var i in recipes) {
        final query1 = await supabaseClient.from('Reviews')
            .select('id, user_id, recipe_id, rating, comment')
            .eq('recipe_id', i.id.toString());

        final query2 = await supabaseClient.from('Favorites')
            .select('*')
            .eq('user_id', userId);

        var reviews = query1.map((json) => ReviewModel.fromJson(json)).toList();
        var favorites = query2.map((json) => FavoriteModel.fromJson(json)).toList();

        if (reviews.isNotEmpty) {
          int ratingSum = 0;
          bool isFavorite = false;

          for (var rv in reviews){
            ratingSum += rv.rating;
          }

          if(favorites.isNotEmpty){
            for(var fv in favorites){
              if(i.id == fv.recipeId){
                isFavorite = true;
                break;
              }
            }
          }

          var newRecipe = i.copyWith(ratingSum: ratingSum / reviews.length, isFavorite: isFavorite);
          listByRating.add(newRecipe);
        }
        else{
          bool isFavorite = false;

          if(favorites.isNotEmpty){
            for(var fv in favorites){
              if(i.id == fv.recipeId){
                isFavorite = true;
                break;
              }
            }
          }

          var newRecipe = i.copyWith(ratingSum: 0, isFavorite: isFavorite);
          listByRating.add(newRecipe);
        }
      }
    }

    return listByRating;
  }

}