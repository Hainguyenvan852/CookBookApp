import 'package:flutter/material.dart';
import 'package:recipe_finder_app/features/auth/data/repositories/auth_repository_impl.dart';

import '../../../../core/themes/main_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key, required this.authRepo});
  final AuthRepositoryImpl authRepo;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _emailCtrl = TextEditingController();
  final _emailKey = GlobalKey<FormFieldState>();


  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color cardColor = const Color(0xFF162921);
    final Color accentGreen = const Color(0xFF4ADE80);
    final Color iconCircleColor = const Color(0xFF1F352A);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: iconCircleColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.lock_reset, color: accentGreen, size: 48),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Forgot your password?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Don't worry. Just enter your email address, and we'll send you a link to reset your password.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 40),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _emailCtrl,
                key: _emailKey,
                decoration: InputDecoration(
                  hintText: "nguyen.a@example.com",
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                  filled: true,
                  fillColor: cardColor,
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.white.withOpacity(0.5)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  errorText: ''
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter your email';
                  }
                  else if(!RegExp(r'^\w+@gmail\.com').hasMatch(value)){
                    return 'Invalid email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final isValid = _emailKey.currentState!.validate();
                    if(isValid){
                      final result = await widget.authRepo.recoveryPassword(_emailCtrl.text);
                      result.fold(
                        (fail) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(fail.message), backgroundColor: ColorThemes.primaryAccent,)),
                        (_) => {
                          Navigator.pop(context),
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('The recovery link has been sent. Please check your email!'),
                                backgroundColor: ColorThemes.primaryAccent,
                              )
                          )
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentGreen,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 100),

              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, size: 18, color: Colors.white),
                label: const Text(
                    "Back to login",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)
                ),
              ),

              const SizedBox(height: 20),

              Divider(color: Colors.white.withOpacity(0.1)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Need help? ",
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: Text(
                      "Contact for support",
                      style: TextStyle(
                          color: accentGreen,
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}