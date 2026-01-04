import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_watcher/auth_watcher_event.dart';
import 'package:recipe_finder_app/features/auth/presentation/bloc/auth_watcher/auth_watcher_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthWatcherBloc extends Bloc<AuthWatcherEvent, AuthWatcherState>{

  AuthRepositoryImpl authRepo;
  late final StreamSubscription<AuthState> _authSub;

  AuthWatcherBloc(this.authRepo) : super(AuthWatcherInitial()){
    _authSub = authRepo.onStateChanged.listen((data){
      final AuthChangeEvent event = data.event;
      final session = data.session;

      if(event == AuthChangeEvent.initialSession){
        add(AuthCheckedState(session));
      }

      if(event == AuthChangeEvent.initialSession){
        add(AuthCheckedState(session));
      }

      if(event == AuthChangeEvent.signedIn){
        add(AuthLogIn(session));
      }

      if(event == AuthChangeEvent.signedOut){
        add(AuthSignedOut());
      }

      if(event == AuthChangeEvent.passwordRecovery){
        add(AuthRecoveryPassword());
      }
    });

    on<AuthCheckedState>((event, emit) async{
      if(event.session == null){
        emit(Unauthenticated());
      }
      else{
        final user = await authRepo.getSignedInUser(event.session!.user.id);

        emit(Authenticated(user, event.session!));
      }
    });

    on<AuthLogIn>((event, emit) async{
      final user = await authRepo.getSignedInUser(event.session!.user.id);

      emit(Authenticated(user, event.session!));
    });
    
    on<AuthSignedOut>((event, emit) async{
      emit(Unauthenticated());
    });

    on<AuthRecoveryPassword>((event, emit) async{
      emit(RequestRecoveryPassword());
    });
  }
}



