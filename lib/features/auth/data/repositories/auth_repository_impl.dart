import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_finder_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:recipe_finder_app/core/errors/failure.dart';
import 'package:recipe_finder_app/features/auth/domain/entities/user_entity.dart';
import 'package:recipe_finder_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository{
  
  AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource,);
  
  @override
  Stream<AuthState> get onStateChanged => dataSource.supabaseClient.auth.onAuthStateChange;

  @override
  Future<Either<Failure, UserModel>> signInWithEmail(String email, String password) async{
    try{
      final userProfile = await dataSource.signInWithEmail(email, password);

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
  Future<Either<Failure, UserResponse>> changePassword(String password) async{
    try{
      final response = await dataSource.changePassword(password);
      return Right(response);
    } catch(e){
      return Left(AuthFailure(messageFailure(e)));
    }
  }

  @override
  Future<Either<Failure, String>> recoveryPassword(String email) async{
    try{
      await dataSource.recoveryPassword(email);
      return Right('submitted');
    } catch(e){
      return Left(AuthFailure(messageFailure(e)));
    }
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

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async{
    try{
      final response = await dataSource.signInWithGoogle();
      return Right(response);
    } catch(e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveFcmToken(String fcmToken) async {
    try{
      dataSource.insertFcmToken(fcmToken);
      return Right('success');
    } catch(e){
      return Left(QueryFailure(e.toString()));
    }
  }
}

String messageFailure(Object e) {
  if (e is AuthException) {
    final message = e.message.toLowerCase();

    if (message.contains('invalid login credentials')) {
      return 'Incorrect email or password.';
    }
    if (message.contains('email not confirmed')) {
      return 'Please confirm your email address before logging in.';
    }
    if (message.contains('user already registered')) {
      return 'This email address has already been registered.';
    }
    if (message.contains('password should be at least')) {
      return 'The password is too short; please enter at least 6 characters.';
    }
    if (message.contains('rate limit')) {
      return 'You acted too quickly. Please try again after a few minutes.';
    }
    if (message.contains('network error') || e.statusCode == '500') {
      return 'Network connection error. Please check your internet connection.';
    }
    if (message.contains('token has expired') || message.contains('invalid otp')) {
      return 'The verification code is incorrect or has expired.';
    }
    if (message.contains('already registered') || message.contains('user already exists') ) {
      return 'verify_email';
    }
    if (message.contains('failed to sign in with google')) {
      return 'Sign in failed';
    }

    return e.message;
  }

  if (e.toString().contains('SocketException')) {
    return 'Không có kết nối internet.';
  }

  return 'Đã xảy ra lỗi không mong muốn. Vui lòng thử lại.';
}