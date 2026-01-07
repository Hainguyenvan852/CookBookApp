// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:recipe_finder_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{

  await dotenv.load(fileName: '.env');
  String publicKey = dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? '';
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';

  await Supabase.initialize(url: supabaseUrl, anonKey: publicKey);

  SupabaseClient supabaseClient = SupabaseClient(supabaseUrl, publicKey);

  const webClientId = '496781120744-dkknrtg7s1cpsckqsh8atc1afoh38l89.apps.googleusercontent.com';

  const androidClientId = '496781120744-s7qda91ibqo7uk9ufm59bc6030giv822.apps.googleusercontent.com';

  final googleSignIn = GoogleSignIn.instance;

  await googleSignIn.initialize(
    serverClientId: webClientId,
    clientId: androidClientId,
  );


  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(supabaseClient: supabaseClient, googleSignIn: googleSignIn,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
