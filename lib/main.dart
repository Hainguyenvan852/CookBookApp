import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:recipe_finder_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_watcher/auth_watcher_bloc.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_watcher/auth_watcher_event.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_watcher/auth_watcher_state.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/initial_page.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  runApp(MyApp(supabaseClient: Supabase.instance.client,));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.supabaseClient});
  final SupabaseClient supabaseClient;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late final AuthRemoteDataSource _authRemoteData;
  late final AuthRepositoryImpl _authRepo;

  @override
  void initState() {
    super.initState();
    _authRemoteData = AuthRemoteDataSource(widget.supabaseClient);
    _authRepo = AuthRepositoryImpl(_authRemoteData);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.sizeOf(context),
      minTextAdapt: true,
      builder: (context, child){
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => _authRepo)
          ],
          child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AuthWatcherBloc(_authRepo)),
              ],
              child: SafeArea(
                  child: MaterialApp(
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
                            return NavigatorPage(user: state.user,);
                          }
                          else if(state is Unauthenticated){
                            return LoginPage(authRepo: _authRepo,);
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

