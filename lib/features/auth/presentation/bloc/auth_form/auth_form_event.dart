abstract class AuthFormEvent {}

class EmailChanged extends AuthFormEvent{
  String email;
  EmailChanged(this.email);
}

class NameChanged extends AuthFormEvent{
  String name;
  NameChanged(this.name);
}

class PasswordChanged extends AuthFormEvent{
  String password;
  PasswordChanged(this.password);
}

class OtpCodeChanged extends AuthFormEvent{
  String otpCode;
  OtpCodeChanged(this.otpCode);
}

class ResendOtp extends AuthFormEvent{
  String email;
  ResendOtp(this.email);
}

class SignInPressed extends AuthFormEvent{}

class SignUpPressed extends AuthFormEvent{}

class VerifyEmailPressed extends AuthFormEvent{}