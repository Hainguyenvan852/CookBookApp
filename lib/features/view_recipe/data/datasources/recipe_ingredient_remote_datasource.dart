import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_ingredient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeIngredientRemoteDatasource {
  final SupabaseClient supabaseClient;

  RecipeIngredientRemoteDatasource({required this.supabaseClient});

  Future<List<RecipeIngredientModel>> get(int recipeId) async{
    final query = await supabaseClient.from('Recipe_Ingredients')
        .select('id, recipe_id, ingredient_id, amount')
        .eq('recipe_id', recipeId.toString());

    return query.map((json) => RecipeIngredientModel.fromJson(json)).toList();
  }
}