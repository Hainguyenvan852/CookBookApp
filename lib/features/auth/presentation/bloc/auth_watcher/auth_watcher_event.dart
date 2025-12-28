import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthWatcherEvent {}

class AuthStatusChanged extends AuthWatcherEvent{
  final Session? session;
  AuthStatusChanged(this.session);
}

class AuthSignedOut extends AuthWatcherEvent {}