import 'package:flutter/material.dart';
import 'package:recipe_finder_app/features/auth/presentation/views/verify_email_view.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();

  runApp(VerifyEmailPage());
}

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_rounded, size: 22, color: Colors.white,)
          ),
        ),
        body: VerifyEmailView()
    );
  }
}






