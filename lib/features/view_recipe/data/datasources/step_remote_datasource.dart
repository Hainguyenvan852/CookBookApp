import 'package:recipe_finder_app/features/view_recipe/data/models/step_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StepRemoteDatasource {
  final SupabaseClient supabaseClient;

  StepRemoteDatasource({required this.supabaseClient});

  Future<List<StepModel>> get(int recipeId) async{
    final query = await supabaseClient.from('Recipe_Steps')
        .select('*')
        .eq('recipe_id', recipeId.toString());

    return query.map((json) => StepModel.fromJson(json)).toList();
  }
}