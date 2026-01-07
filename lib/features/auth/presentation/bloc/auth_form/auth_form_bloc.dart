import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_event.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_form/auth_form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState>{
  AuthRepositoryImpl authRepo;

  AuthFormBloc(this.authRepo) : super(AuthFormState.initial()){

    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, authFailureOrSuccessOption: none()));
    });

    on<NameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.name, authFailureOrSuccessOption: none()));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, authFailureOrSuccessOption: none()));
    });

    on<OtpCodeChanged>((event, emit) {
      emit(state.copyWith(otpCode: event.otpCode, authFailureOrSuccessOption: none()));
    });

    on<ResendOtp>((event, emit){
      authRepo.resendOtp(event.email);
    });

    on<SignInPressedWithEmail>((event, emit) async{
      emit(state.copyWith(isSubmitting: true));

      final failOrSuccess = await authRepo.signInWithEmail(state.email.trim(), state.password.trim());

      emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: some(failOrSuccess)));
      emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: none()));
    });

    on<SignInPressedWithGoogle>((event, emit) async{
      emit(state.copyWith(isSubmitting: true));

      final failOrSuccess = await authRepo.signInWithGoogle();

      emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: some(failOrSuccess)));
      emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: none()));
    });

    on<SignUpPressed>((event, emit) async{
      emit(state.copyWith(isSubmitting: true));

      final result = await authRepo.signUp(state.email, state.password, state.fullName!);

      result.fold(
          (f) => emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: some(Left(f)))),
          (_) => emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: none(), signUpStepSuccess: true)),
      );
      emit(state.copyWith(authFailureOrSuccessOption: none(), signUpStepSuccess: false));
    });

    on<VerifyEmailPressed>((event, emit) async{
      emit(state.copyWith(isSubmitting: true));

      final failOrSuccess = await authRepo.verifyEmail(state.email, state.otpCode!);

      emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: some(failOrSuccess)));
    });
  }


}