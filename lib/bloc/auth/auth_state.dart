part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoadSuccess extends AuthState {
  const AuthLoadSuccess({required this.data});

  final Auth data;

  @override
  List<Object?> get props => [data];
}

final class AuthLoadFailed extends AuthState {
  const AuthLoadFailed({
    required this.errorMessage
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
