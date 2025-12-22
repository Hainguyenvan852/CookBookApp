import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/login_page.dart';
import 'package:recipe_finder_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:recipe_finder_app/features/homepage/presentation/pages/navigator_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  String publicKey = dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? '';
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';

  await Supabase.initialize(url: supabaseUrl, anonKey: publicKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: MediaQuery.sizeOf(context),
      minTextAdapt: true,
      builder: (context, child){
        return SafeArea(
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: AppThemes.mainTheme,
              debugShowCheckedModeBanner: false,
              home: const NavigatorPage(),
            )
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
