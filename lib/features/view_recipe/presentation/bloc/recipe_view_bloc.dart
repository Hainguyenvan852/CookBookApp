import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';
import 'package:recipe_finder_app/features/view_recipe/data/repositories/favorite_repository_impl.dart';
import 'package:recipe_finder_app/features/view_recipe/data/repositories/recipe_repository_ipml.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/bloc/recipe_view_event.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/bloc/recipe_view_state.dart';

class RecipeViewBloc extends Bloc<RecipeViewEvent, RecipeViewState>{
  final RecipeRepositoryIpml recipeRepo;
  final FavoriteRepositoryImpl favoriteRepo;
  final String userId;

  RecipeViewBloc({required this.recipeRepo, required this.userId, required this.favoriteRepo}) : super(RecipeViewState.initial()){

    on<LoadRecipe>((event, emit) async{
      final all =  await recipeRepo.getAll(userId);
      List<RecipeModel> newlyList = [];
      List<RecipeModel> todayList = [];
      List<RecipeModel> favoriteList = [];
      List<RecipeModel> allList = [];
      String error = '';

      all.fold(
        (fail) => error= fail.message,
        (recipes){
          if(recipes.isNotEmpty){

            favoriteList = recipes.where((recipe) => recipe.isFavorite == true).toList();

            recipes.shuffle();
            todayList = recipes.take(7).toList();

            recipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            newlyList = recipes.take(5).toList();

            recipes.sort((a, b) => b.ratingSum!.compareTo(a.ratingSum!));
            allList = recipes;
          }
        }
      );

      if(error.isEmpty){
        emit(state.copyWith(allRecipeList: allList, newlyRecipeList: newlyList, favoriteList: favoriteList, todayRecipeList: todayList, isLoading: false));
      }else{
        emit(state.copyWith(error: error, isLoading: false));
      }
    });

    on<FavoritePressed>((event, emit) async{
      final result = await favoriteRepo.insertFavorite(event.favoriteModel);

      result.fold(
        (fail) => emit(state.copyWith(error: fail.message)),
        (_){
          add(LoadRecipe());
        }
      );
    });

    on<NoFavoritePressed>((event, emit) async{
      final result = await favoriteRepo.deleteFavorite(event.favoriteModel);

      result.fold(
        (fail) => emit(state.copyWith(error: fail.message)),
        (_){
          add(LoadRecipe());
        }
      );
    });
  }
}