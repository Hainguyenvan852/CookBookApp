import 'package:flutter/material.dart';
import 'package:recipe_finder_app/core/themes/main_theme.dart';

import '../../data/repositories/auth_repository_impl.dart';


class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key, required this.authRepo, required this.typeRequest});
  final AuthRepositoryImpl authRepo;
  final int typeRequest; // 0 - reset, 1 - update

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  final _validateKey = GlobalKey<FormState>();

  final TextEditingController _currentPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();


  @override
  void dispose() {
    _currentPassController.dispose();
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color iconCircleColor = const Color(0xFF1F352A);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: (widget.typeRequest == 1) ? AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          title: const Text("Change password",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
          ),
          centerTitle: true,
        ) : AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Change password",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: iconCircleColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.lock_reset, color: ColorThemes.primaryAccent, size: 48),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "Your new password must be different from the password you used previously.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              Form(
                key: _validateKey,
                child: Column(
                  children: [
                    _buildLabel("NEW PASSWORD"),
                    _buildPasswordField(
                      controller: _newPassController,
                      hintText: "Enter new password",
                      prefixIcon: Icons.vpn_key_outlined,
                      obscureText: _obscureNew,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureNew = !_obscureNew;
                        });
                      },
                      cardColor: ColorThemes.cardBackground,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Please enter your new password';
                        } else if(_newPassController.text != _confirmPassController.text){
                          return 'New password and confirm password do not match';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    _buildLabel("CONFIRM NEW PASSWORD"),
                    _buildPasswordField(
                      controller: _confirmPassController,
                      hintText: "Re-enter your new password.",
                      prefixIcon: Icons.verified_user_outlined,
                      obscureText: _obscureConfirm,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                      cardColor: ColorThemes.cardBackground,
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Please enter your confirm password';
                        } else if(_newPassController.text != _confirmPassController.text){
                          return 'New password and confirm password do not match';
                        }
                        return null;
                      },
                    ),
                  ],
                )
              ),

              const SizedBox(height: 100),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final isValid = _validateKey.currentState!.validate();

                    if(isValid){
                      final result = await widget.authRepo.changePassword(_newPassController.text);
                      result.fold(
                        (fail) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(fail.message), backgroundColor: ColorThemes.primaryAccent,)),
                        (_) => {
                          if(widget.typeRequest == 0){
                            widget.authRepo.signOut()
                          },
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your password has been updated'), backgroundColor: ColorThemes.primaryAccent,)),
                        }
                      );
                    }
                  },
                  icon: const Icon(Icons.save, size: 20),
                  label: const Text(
                    "Save change",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorThemes.primaryAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            color: const Color(0xFF4ADE80).withOpacity(0.8),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    required String? Function(String? value)? validator,
    required Color cardColor,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        errorText: '',
        fillColor: cardColor,
        filled: true,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 14),
        prefixIcon: Icon(prefixIcon, color: Colors.white.withOpacity(0.5), size: 20),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.white.withOpacity(0.5),
            size: 20,
          ),
          onPressed: onToggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
      validator: validator,
    );
  }
}