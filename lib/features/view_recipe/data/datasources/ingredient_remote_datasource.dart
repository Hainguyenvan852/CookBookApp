import 'package:recipe_finder_app/features/view_recipe/data/models/ingredient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IngredientRemoteDatasource {
  final SupabaseClient supabaseClient;

  IngredientRemoteDatasource({required this.supabaseClient});

  Future<IngredientModel> get(int ingredientId) async{
    final query = await supabaseClient.from('Ingredients')
        .select('id, name')
        .eq('id', ingredientId.toString())
        .single();

    return IngredientModel.fromJson(query);
  }
}