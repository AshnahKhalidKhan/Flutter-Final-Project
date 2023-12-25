import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationEvents.dart';
import 'package:flutter_final_project/Blocs/AuthenticationStates.dart';
import 'package:flutter_final_project/Core/Repositories/AuthenticationRepository.dart';
import 'package:flutter_final_project/Models/UserModel.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> 
{
  final AuthenticationRepository authenticationRepository;
  
  AuthenticationBloc({required this.authenticationRepository}) : super(AuthenticationInitialState()) 
  {
    on<AuthenticationEvent>((event, emit) {});

    on<AuthenticationSignUpWithEmailEvent>((event, emit) async 
    {
      emit(AuthenticationLoadingState(isLoading: true));
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
        if (user != null) 
        {
          emit(AuthenticationSuccessOrLoadedState(user));
        } 
        else 
        {
          emit(const AuthenticationErrorState('Sign Up Failed'));
        }
      } 
      catch (e) 
      {
        print(e.toString());
      }
      emit(AuthenticationLoadingState(isLoading: false));
    });

    on<AuthenticationSignOutEvent>((event, emit) async 
    {
      emit(AuthenticationLoadingState(isLoading: true));
      try 
      {
        authenticationRepository.signOut();
      } 
      catch (e) 
      {
        print('error');
        print(e.toString());
      } 
      emit(AuthenticationLoadingState(isLoading: false));
    });
  }
}