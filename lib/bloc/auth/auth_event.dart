part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthLogin extends AuthEvent {
  final AuthRequest request;

  const AuthLogin(this.request);
}

final class AuthLogout extends AuthEvent {
  const AuthLogout();
}
