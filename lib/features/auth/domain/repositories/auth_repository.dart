import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/features/auth/domain/cores/failure.dart';
import 'package:recipe_finder_app/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  Future<Either<Failure, AuthResponse>> signUp(String email, String password, String fullName);
  Future<Either<Failure, AuthResponse>> verifyEmail(String email, String otpCode);
  Future<void> signOut();
  Future<UserEntity> getSignedInUser(String userId);
  Stream<AuthState> get onStateChanged;
  Future<Either<Failure, ResendResponse>> resendOtp(String email);
}