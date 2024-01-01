import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/models/UserModel.dart';

abstract class AuthenticationState extends Equatable
{
  const AuthenticationState();
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState
{
  //Profile page initial load
}

class AuthenticationLoadingState extends AuthenticationState
{
  @override
  List<Object> get props => [];
}

class AuthenticationSuccessState extends AuthenticationState
{
  final AppUser user;
  const AuthenticationSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationErrorState extends AuthenticationState
{
  final String error;
  const AuthenticationErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class AuthenticationPasswordResettedState extends AuthenticationState
{
  final String message;
  const AuthenticationPasswordResettedState(this.message);

  @override
  List<Object> get props => [message];
}

class AuthenticationSignedOutState extends AuthenticationState
{
  //Profile page initial load
}