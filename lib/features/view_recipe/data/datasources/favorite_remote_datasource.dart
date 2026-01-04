import 'package:recipe_finder_app/features/view_recipe/data/models/favorite_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteRemoteDatasource {
  final SupabaseClient supabaseClient;
  FavoriteRemoteDatasource({required this.supabaseClient});

  Future<List<FavoriteModel>> getFavoriteByUser(String userId) async {
    final query = await supabaseClient.from('Favorites')
        .select('*')
        .eq('user_id', userId);

    return query.map((json) => FavoriteModel.fromJson(json)).toList();
  }

  Future<void> delete(FavoriteModel favorite) async{
    await supabaseClient.from('Favorites')
        .delete()
        .eq('recipe_id', favorite.recipeId)
        .eq('user_id', favorite.userId);
  }

  Future<void> insert(FavoriteModel favorite) async{
    await supabaseClient.from('Favorites')
      .insert({
        'user_id' : favorite.userId,
        'recipe_id' : favorite.recipeId
      });
  }
}