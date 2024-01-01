import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_events.dart';
import 'package:flutter_final_project/blocs/authentication/authentication_states.dart';
import 'package:flutter_final_project/core/repositories/authentication_repository.dart';
import 'package:flutter_final_project/models/user_model.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> 
{
  final AuthenticationRepository authenticationRepository;
  AppUser? signedInUser;
  
  AuthenticationBloc({required this.authenticationRepository}) : super(AuthenticationInitialState()) 
  {
    on<AuthenticationSignUpWithEmailEvent>((event, emit) async 
    {
      emit(AuthenticationLoadingState());
      try
      {
        final AppUser? user = await authenticationRepository.signUpWithEmail
        (
          name: event.name,
          email: event.email,
          password: event.password,
          role: event.role,
          campus: event.campus ?? event.campus
        );
        emit(AuthenticationSuccessState(user!));
      } 
      catch (e) 
      {
        emit(AuthenticationErrorState(e.toString()));
      }
    });

    on<AuthenticationSignInWithEmailEvent>((event, emit) async 
    {
      emit(AuthenticationLoadingState());
      try 
      {
        final AppUser? user = await authenticationRepository.signInWithEmail
        (
          email: event.email,
          password: event.password
        );
        emit(AuthenticationSuccessState(user!));
      } 
      catch (e) 
      {
        emit(AuthenticationErrorState(e.toString()));
      }
    });

    on<AuthenticationSignOutEvent>((event, emit) async 
    {
      emit(AuthenticationLoadingState());
      try 
      {
        await authenticationRepository.signOut();
        emit(AuthenticationSignedOutState());
      } 
      catch (e) 
      {
        emit(AuthenticationErrorState(e.toString()));
      } 
    });

    on<AuthenticationForgotPasswordEvent>((event, emit) async 
    {
      emit(AuthenticationLoadingState());
      try 
      {
        final String message = await authenticationRepository.forgotPassword(email: event.email);
        emit(AuthenticationPasswordResettedState(message));
      } 
      catch (e) 
      {
        emit(AuthenticationErrorState(e.toString()));
      } 
    });
  }
}