import 'package:equatable/equatable.dart';
import 'package:flutter_final_project/Models/UserModel.dart';

abstract class AuthenticationState extends Equatable
{
  const AuthenticationState();
  List<Object> get props => [];
}

class AuthenticationEmptyState extends AuthenticationState
{
  //Ye empty rahay ga
}

class AuthenticationInitialState extends AuthenticationState
{
  //Ye bhi empty rahay ga
}

class AuthenticationLoadingState extends AuthenticationState
{
  final bool isLoading;
  const AuthenticationLoadingState({required this.isLoading});
}

class AuthenticationSuccessOrLoadedState extends AuthenticationState
{
  final AppUser user;
  const AuthenticationSuccessOrLoadedState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationSuccessfulSignOutState extends AuthenticationState
{
  @override
  List<Object> get props => [];
}

class AuthenticationErrorState extends AuthenticationState
{
  final String error;
  const AuthenticationErrorState(this.error);

  @override
  List<Object> get props => [error];
}