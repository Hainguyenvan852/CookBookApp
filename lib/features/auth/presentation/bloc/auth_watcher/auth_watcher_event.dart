import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthWatcherEvent {}

class AuthLogIn extends AuthWatcherEvent{
  final Session? session;
  AuthLogIn(this.session);
}

class AuthCheckedState extends AuthWatcherEvent{
  final Session? session;
  AuthCheckedState(this.session);
}

class AuthSignedOut extends AuthWatcherEvent {}

class AuthRecoveryPassword extends AuthWatcherEvent{}