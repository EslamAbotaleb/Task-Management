part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// Intital For State
final class AuthInitial extends AuthState {}

// Loading
final class AuthLoading extends AuthState {}

// Success
final class AuthSuccess extends AuthState {
  final LoginEntity loginEntity;
  const AuthSuccess({required this.loginEntity});

  @override
  List<Object> get props => [loginEntity];
}

// Error
final class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
