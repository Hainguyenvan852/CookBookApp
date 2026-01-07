import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/core/themes/scroll_behavior.dart';
import 'package:recipe_finder_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:recipe_finder_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_watcher/auth_watcher_bloc.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_watcher/auth_watcher_state.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/change_password_page.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/initial_page.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/login_page.dart';
import 'package:recipe_finder_app/features/view_recipe/data/datasources/favorite_remote_datasource.dart';
import 'package:recipe_finder_app/features/view_recipe/data/datasources/recipe_remote_datasource.dart';
import 'package:recipe_finder_app/features/view_recipe/data/repositories/favorite_repository_impl.dart';
import 'package:recipe_finder_app/features/view_recipe/data/repositories/recipe_repository_ipml.dart';
import 'package:recipe_finder_app/features/view_recipe/presentation/bloc/recipe_view/recipe_view_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/view_recipe/presentation/bloc/recipe_view/recipe_view_event.dart';
import 'features/view_recipe/presentation/pages/navigator_page.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  String publicKey = dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? '';
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: publicKey,
  );

  const webClientId = '496781120744-dkknrtg7s1cpsckqsh8atc1afoh38l89.apps.googleusercontent.com';

  const androidClientId = '496781120744-s7qda91ibqo7uk9ufm59bc6030giv822.apps.googleusercontent.com';

  final googleSignIn = GoogleSignIn.instance;

  await googleSignIn.initialize(
    serverClientId: webClientId,
    clientId: androidClientId,
  );

  PlatformDispatcher.instance.onError = (error, stack) {
    if (error is AuthException) {
      if (error.statusCode == 'otp_expired' || error.code == 'access_denied') {
        print("Bắt được lỗi: Link reset password đã hết hạn!");
        return true;
      }
    }

    return false;
  };

  runApp(MyApp(supabaseClient: Supabase.instance.client, googleSignIn: googleSignIn,));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.supabaseClient, required this.googleSignIn});
  final SupabaseClient supabaseClient;
  final GoogleSignIn googleSignIn;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final AuthRemoteDataSource _authRemoteData;
  late final AuthRepositoryImpl _authRepo;
  late final RecipeRepositoryIpml _recipeRepo;
  late final RecipeRemoteDataSource _recipeRemoteDataSource;
  late final FavoriteRemoteDatasource _favoriteRemoteDatasource;
  late final FavoriteRepositoryImpl _favoriteRepositoryImpl;

  @override
  void initState() {
    super.initState();
    _authRemoteData = AuthRemoteDataSource(supabaseClient:  widget.supabaseClient, googleSignIn: widget.googleSignIn);
    _authRepo = AuthRepositoryImpl(_authRemoteData);

    _favoriteRemoteDatasource = FavoriteRemoteDatasource(supabaseClient: widget.supabaseClient);
    _recipeRemoteDataSource = RecipeRemoteDataSource(supabaseClient: widget.supabaseClient, favoriteDatasource: _favoriteRemoteDatasource);
    _recipeRepo = RecipeRepositoryIpml(datasource: _recipeRemoteDataSource);
    _favoriteRepositoryImpl = FavoriteRepositoryImpl(datasource: _favoriteRemoteDatasource);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.sizeOf(context),
      minTextAdapt: true,
      builder: (context, child){
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => _authRepo),
            RepositoryProvider(create: (context) => _recipeRepo)
          ],
          child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AuthWatcherBloc(_authRepo)),
              ],
              child: SafeArea(
                  child: MaterialApp(
                    scrollBehavior: NoStretchBehavior(),
                    debugShowCheckedModeBanner: false,
                    theme: AppThemes.mainTheme,
                    title: 'Cookbook App',
                    home: BlocConsumer<AuthWatcherBloc, AuthWatcherState>(
                        listenWhen: (p, c) => p.runtimeType != c.runtimeType,
                        listener: (context, state){
                          if(state is AuthWatcherFailure){
                            String message = state.message;
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(message,),
                                  backgroundColor: ColorThemes.primaryAccent,
                                ),
                            );
                          }
                        },
                        builder: (context, state){
                          if(state is AuthWatcherInitial){
                            return InitialPage();
                          }
                          else if(state is Authenticated){
                            return BlocProvider(
                                create: (context) => RecipeViewBloc(recipeRepo: _recipeRepo, userId: state.user.id, favoriteRepo: _favoriteRepositoryImpl)..add(LoadRecipe()),
                                child: NavigatorPage(user: state.user, authRepo: _authRepo, supabaseClient: widget.supabaseClient,)
                            );
                          }
                          else if(state is Unauthenticated){
                            return LoginPage(authRepo: _authRepo,);
                          }
                          else if(state is RequestRecoveryPassword){
                            return ChangePasswordPage(authRepo: _authRepo, typeRequest: 0,);
                          }
                          else if(state is AuthWatcherFailure){
                            return LoginPage(authRepo: _authRepo,);
                          }
                          else{
                            return Scaffold(
                              body: Center(child: LoadingAnimationWidget.waveDots(color: ColorThemes.primaryAccent, size: 30)),
                            );
                          }
                        }
                    ),
                  )
              )
          ),
        );
      },
    );
  }
}

