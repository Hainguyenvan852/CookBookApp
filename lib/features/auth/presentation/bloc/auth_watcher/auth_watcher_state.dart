import 'package:recipe_finder_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthWatcherState{
  AuthWatcherState();
}

class AuthWatcherInitial extends AuthWatcherState {}

class Authenticated extends AuthWatcherState{
  UserModel user;
  Session session;
  Authenticated(this.user, this.session);
}

class Unauthenticated extends AuthWatcherState{}

class AuthWatcherFailure extends AuthWatcherState {
  final String message;
  AuthWatcherFailure(this.message);
}

