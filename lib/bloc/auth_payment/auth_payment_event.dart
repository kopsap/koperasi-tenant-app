part of 'auth_payment_bloc.dart';

sealed class AuthPaymentEvent extends Equatable {
  const AuthPaymentEvent();

  @override
  List<Object> get props => [];
}

final class AuthPaymentRequested extends AuthPaymentEvent {
  final AuthRequest request;

  const AuthPaymentRequested(this.request);
}
