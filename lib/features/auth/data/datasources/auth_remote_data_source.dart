import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSource(this.supabaseClient);

  Future<UserModel> signIn(String email, String password) async{
    final response = await supabaseClient.auth.signInWithPassword(password: password, email: email);

    final query = await supabaseClient
        .from('Users')
        .select('id, username, email, is_active, role, avatar_url')
        .filter('id', 'eq', response.user!.id)
        .single();

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
        .filter('id', 'eq', userId)
        .single();

    return UserModel.fromJson(query);
  }
}