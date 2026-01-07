import 'package:recipe_finder_app/features/view_recipe/data/models/recipe_model.dart';

class RecipeViewState {
  bool isLoading;
  List<RecipeModel> allRecipeList;
  List<RecipeModel> todayRecipeList;
  List<RecipeModel> favoriteList;
  List<RecipeModel> newlyRecipeList;
  List<RecipeModel> favoriteListByFilter;
  String? error;

  RecipeViewState({
    required this.isLoading,
    required this.allRecipeList,
    required this.newlyRecipeList,
    required this.favoriteList,
    required this.todayRecipeList,
    required this.favoriteListByFilter,
    this.error
  });

  factory RecipeViewState.initial() => RecipeViewState(
      isLoading: true,
      allRecipeList: [],
      newlyRecipeList: [],
      favoriteList: [],
      todayRecipeList: [],
      favoriteListByFilter: []
  );

  RecipeViewState copyWith({
    bool? isLoading,
    List<RecipeModel>? allRecipeList,
    List<RecipeModel>? favoriteList,
    List<RecipeModel>? newlyRecipeList,
    List<RecipeModel>? todayRecipeList,
    List<RecipeModel>? favoriteListByFilter,
    String? error
  }) => RecipeViewState(
    isLoading: isLoading ?? this.isLoading,
    allRecipeList: allRecipeList ?? this.allRecipeList,
    newlyRecipeList: newlyRecipeList ?? this.newlyRecipeList,
    favoriteList: favoriteList ?? this.favoriteList,
    todayRecipeList: todayRecipeList ?? this.todayRecipeList,
    favoriteListByFilter: favoriteListByFilter ?? this.favoriteListByFilter,
    error: error ?? this.error
  );
}