part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class LoginEvent extends AuthEvent {
  final String userName;
  final String password;

  const LoginEvent({required this.userName, required this.password});

  @override
  List<Object> get props => [userName, password];
}

final class LogoutEvent extends AuthEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}
