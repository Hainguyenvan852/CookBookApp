import 'package:dartz/dartz.dart';
import 'package:recipe_finder_app/core/failure.dart';

class AuthFormState {
  String email;
  String password;
  String? newPassword;
  String? fullName;
  bool isSubmitting;
  Option<Either<Failure, Object>> authFailureOrSuccessOption;
  String? otpCode;
  bool signUpStepSuccess;

  AuthFormState({
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.authFailureOrSuccessOption,
    required this.signUpStepSuccess,
    this.otpCode,
    this.fullName,
  });

  factory AuthFormState.initial() => AuthFormState(
    isSubmitting: false,
    signUpStepSuccess: false,
    authFailureOrSuccessOption: none(),
    email: '',
    password: '',
  );

  AuthFormState copyWith({
    bool? isSubmitting,
    Option<Either<Failure, Object>>? authFailureOrSuccessOption,
    String? otpCode,
    bool? signUpStepSuccess,
    String? email,
    String? password,
    String? confirmPassword,
    String? fullName,
  }) =>
      AuthFormState(
          isSubmitting: isSubmitting ?? this.isSubmitting,
          authFailureOrSuccessOption: authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
          signUpStepSuccess: signUpStepSuccess ?? this.signUpStepSuccess,
          otpCode: otpCode ?? this.otpCode,
          email: email ?? this.email,
          password: password ?? this.password,
          fullName: fullName ?? this.fullName,
      );
}

