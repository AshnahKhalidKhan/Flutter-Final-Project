import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  List<Object> get props => [];
}

class AuthenticationSignOutEvent extends AuthenticationEvent {}

class AuthenticationSignUpWithEmailEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;
  final String role;
  final String? campus;

  const AuthenticationSignUpWithEmailEvent(
      this.name, this.email, this.password, this.role, this.campus);

  @override
  List<Object> get props => [email, password];
}

class AuthenticationSignInWithEmailEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationSignInWithEmailEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthenticationSignInWithGoogleEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationSignInWithGoogleEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthenticationForgotPasswordEvent extends AuthenticationEvent {
  final String email;

  const AuthenticationForgotPasswordEvent(this.email);

  @override
  List<Object> get props => [email];
}
