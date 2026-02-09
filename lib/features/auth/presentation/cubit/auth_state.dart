part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthPasswordVisibilityChanged extends AuthState {
  final bool isVisible;
  AuthPasswordVisibilityChanged({required this.isVisible});
}

class AuthSuccess extends AuthState {
  final String token;
  AuthSuccess({required this.token});
}

class AuthError extends AuthState {
  final String message;
  AuthError({required this.message});
}
