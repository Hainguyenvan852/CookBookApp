import 'dart:async';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  final GoogleSignIn googleSignIn;
  AuthRemoteDataSource({required this.supabaseClient, required this.googleSignIn});

  Future<UserModel> signInWithEmail(String email, String password) async{
    final response = await supabaseClient.auth.signInWithPassword(password: password, email: email);

    final query = await supabaseClient
        .from('Users')
        .select('id, username, email, is_active, role, avatar_url')
        .filter('id', 'eq', response.user!.id)
        .single()
        .timeout(Duration(seconds: 10), onTimeout: () {
          throw TimeoutException("Kết nối tới server quá lâu!");
        });


    return UserModel.fromJson(query);
  }

  Future<UserModel> signInWithGoogle() async{

    final scopes = ['email', 'profile'];

    final googleUser = await googleSignIn.attemptLightweightAuthentication();

    if (googleUser == null) {
      throw AuthException('Failed to sign in with Google.');
    }

    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
            await googleUser.authorizationClient.authorizeScopes(scopes);

    final idToken = googleUser.authentication.idToken;
    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }

    final response = await supabaseClient.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );

    final query = await supabaseClient
        .from('Users')
        .select('id, username, email, is_active, role, avatar_url')
        .filter('id', 'eq', response.user!.id)
        .single()
        .timeout(Duration(seconds: 10), onTimeout: () {
      throw TimeoutException("Kết nối tới server quá lâu!");
    });

    return UserModel.fromJson(query);
  }

  Future<AuthResponse> signUp(String email, String password, String fullName){
    return supabaseClient.auth.signUp(
      password: password,
      email: email, channel: OtpChannel.sms,
      emailRedirectTo: 'io.supabase.flutterapp://login-callback',
      data: {
        'full_name': fullName
      }
    );
  }

  Future<ResendResponse> resendOtp(String email){
    return supabaseClient.auth.resend(
      type: OtpType.signup,
      email: email
    );
  }

  Future<UserResponse> changePassword(String password){
    return supabaseClient.auth.updateUser(
      UserAttributes(
        password: password
      )
    );
  }

  Future<void> recoveryPassword(String email){
    return supabaseClient.auth.resetPasswordForEmail(email, redirectTo: 'io.supabase.flutterapp://login-callback');
  }

  Future<void> signOut(){
    return supabaseClient.auth.signOut();
  }

  Future<AuthResponse> verifyEmail(String email, String otpCode){
    return supabaseClient.auth.verifyOTP(email: email, type: OtpType.signup, token: otpCode);
  }

  Future<UserModel> getCurrentUser(String userId) async {
    final query = await supabaseClient
        .from('Users')
        .select('id, username, email, is_active, role, avatar_url')
        .eq('id', userId)
        .single();

    return UserModel.fromJson(query);
  }
}