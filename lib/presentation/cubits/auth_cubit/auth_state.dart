part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  final User user;

  const LoginSuccess({required this.user});
}

class LoginError extends AuthState {
  final String message;

  const LoginError({required this.message});
}
