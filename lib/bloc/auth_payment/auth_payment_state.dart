part of 'auth_payment_bloc.dart';

sealed class AuthPaymentState extends Equatable {
  const AuthPaymentState();

  @override
  List<Object?> get props => [];
}

final class AuthPaymentInitial extends AuthPaymentState {}

final class AuthPaymentLoading extends AuthPaymentState {}

final class AuthPaymentLoadSuccess extends AuthPaymentState {
  const AuthPaymentLoadSuccess({required this.data});

  final Auth data;

  @override
  List<Object?> get props => [data];
}

final class AuthPaymentLoadFailed extends AuthPaymentState {
  const AuthPaymentLoadFailed({
    required this.errorMessage
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
