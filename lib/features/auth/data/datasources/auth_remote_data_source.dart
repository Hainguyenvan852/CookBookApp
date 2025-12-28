import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthRemoteDataSource {
  final SupabaseClient supabase;
  AuthRemoteDataSource(this.supabase);

  Future<UserModel> signIn(String email, String password) async{
    final response = await supabase.auth.signInWithPassword(password: password, email: email);

    final query = await supabase
        .from('Users')
        .select('id, username, email, is_active, role, avatar_url')
        .filter('id', 'eq', response.user!.id)
        .single();

    return UserModel.fromJson(query);
  }

  Future<AuthResponse> signUp(String email, String password, String fullName){
    return supabase.auth.signUp(
      password: password,
      email: email, channel: OtpChannel.sms,
      emailRedirectTo: 'io.supabase.flutterapp://login-callback',
      data: {
        'full_name': fullName
      }
    );
  }

  Future<ResendResponse> resendOtp(String email){
    return supabase.auth.resend(
      type: OtpType.signup,
      email: email
    );
  }

  Future<void> signOut(){
    return supabase.auth.signOut();
  }

  Future<AuthResponse> verifyEmail(String email, String otpCode){
    return supabase.auth.verifyOTP(email: email, type: OtpType.signup, token: otpCode);
  }

  Future<UserModel> getCurrentUser(String userId) async {
    final query = await supabase
        .from('Users')
        .select('id, username, email, is_active, role, avatar_url')
        .filter('id', 'eq', userId)
        .single();

    return UserModel.fromJson(query);
  }
}