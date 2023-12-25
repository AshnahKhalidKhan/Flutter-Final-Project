import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable
{
  const AuthenticationEvent();
  List<Object> get props => [];
}

class AuthenticationSignUpWithEmailEvent extends AuthenticationEvent 
{
  final String name;
  final String email;
  final String password;
  final String role;
  final String? campus;
  
  const AuthenticationSignUpWithEmailEvent(this.name, this.email, this.password, this.role, this.campus);

  @override
  List<Object> get props => [email, password];
}


class AuthenticationSignOutEvent extends AuthenticationEvent 
{
  //Ye empty rahay ga
}