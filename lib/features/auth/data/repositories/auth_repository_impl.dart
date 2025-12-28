import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_finder_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/features/auth/domain/cores/failure.dart';
import 'package:recipe_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository{
  
  AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource,);
  
  @override
  Stream<AuthState> get onStateChanged => dataSource.supabase.auth.onAuthStateChange;

  @override
  Future<Either<Failure, UserModel>> signIn(String email, String password) async{
    try{
      final userProfile = await dataSource.signIn(email, password);

      return Right(userProfile);
    } catch (e){
      return Left(AuthFailure(messageFailure(e)));
    }
  }

  @override
  Future<void> signOut() async {
    await dataSource.signOut();
  }

  @override
  Future<Either<Failure, AuthResponse>> signUp(String email, String password, String fullName) async{
    try{
      final response = await dataSource.signUp(email, password, fullName);
      return Right(response);
    } catch(e){
      return Left(AuthFailure(messageFailure(e)));
    }
  }

  @override
  Future<UserModel> getSignedInUser(String userId) async{
    final currentUser = await dataSource.getCurrentUser(userId);
    return currentUser;
  }

  @override
  Future<Either<Failure, AuthResponse>> verifyEmail(String email, String otpCode) async{
    try{
      final response = await dataSource.verifyEmail(email, otpCode);

      if (response.user != null) {
        if (kDebugMode) {
          print("Xác thực thành công: ${response.user!.email}");
        }
      }
      return Right(response);
    } catch(e){
      return Left(AuthFailure(messageFailure(e)));
    }
  }

  @override
  Future<Either<Failure, ResendResponse>> resendOtp(String email) async {
    try{
      final response = await dataSource.resendOtp(email);
      return Right(response);
    } catch(e){
      return Left(AuthFailure(messageFailure(e)));
    }
  }
}

String messageFailure(Object e) {
  if (e is AuthException) {
    final message = e.message.toLowerCase();

    if (message.contains('invalid login credentials')) {
      return 'Email hoặc mật khẩu không chính xác.';
    }
    if (message.contains('email not confirmed')) {
      return 'Vui lòng xác nhận email trước khi đăng nhập.';
    }
    if (message.contains('user already registered')) {
      return 'Email này đã được đăng ký.';
    }
    if (message.contains('password should be at least')) {
      return 'Mật khẩu quá ngắn, vui lòng nhập ít nhất 6 ký tự.';
    }
    if (message.contains('rate limit')) {
      return 'Bạn thao tác quá nhanh. Vui lòng thử lại sau vài phút.';
    }
    if (message.contains('network error') || e.statusCode == '500') {
      return 'Lỗi kết nối mạng. Vui lòng kiểm tra internet.';
    }
    if (message.contains('token has expired') || message.contains('invalid otp')) {
      return 'Mã xác thực không chính xác hoặc đã hết hạn.';
    }
    if (message.contains('already registered') || message.contains('user already exists') ) {
      return 'verify_email';
    }

    return e.message;
  }

  if (e.toString().contains('SocketException')) {
    return 'Không có kết nối internet.';
  }

  return 'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.';
}