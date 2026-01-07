import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/ingredient_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/step_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/repositories/ingredient_repository_impl.dart';
import 'package:recipe_finder_app/features/view_recipe/data/repositories/step_repository_impl.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/bloc/step_ingredient_bloc/step_ingredient_event.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/bloc/step_ingredient_bloc/step_ingredient_state.dart';

class StepIngredientBloc extends Bloc<StepIngredientEvent, StepIngredientState>{

  final StepRepositoryImpl stepRepositoryImpl;
  final IngredientRepositoryImpl ingredientRepositoryImpl;

  StepIngredientBloc({required this.stepRepositoryImpl, required this.ingredientRepositoryImpl, }) : super(StepIngredientState.initial()){
    on<LoadStepAndIngredient>((event, emit)async{
      final result1 = await stepRepositoryImpl.getStep(event.recipeId);
      final result2 = await ingredientRepositoryImpl.getIngredient(event.recipeId);

      List<StepModel> steps = [];
      List<IngredientModel> ingredients = [];
      String error = '';

      result1.fold(
          (fail) => error = fail.message,
          (result){
            steps = result;
          }
      );

      result2.fold(
          (fail) => error = fail.message,
          (result) {
            ingredients = result;
          }
      );

      if(error.isNotEmpty){
        emit(state.copyWith(error: error, isLoading: false));
      } else{
        emit(state.copyWith(steps: steps, ingredients: ingredients, isLoading: false));
      }
    });

  }
}