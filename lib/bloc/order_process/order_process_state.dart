part of 'order_process_bloc.dart';

sealed class OrderProcessState extends Equatable {
  const OrderProcessState();

  @override
  List<Object?> get props => [];
}

final class OrderProcessInitial extends OrderProcessState {}

final class OrderProcessLoading extends OrderProcessState {}

final class OrderProcessCreateSuccess extends OrderProcessState {
  const OrderProcessCreateSuccess({required this.orderCode});

  final String orderCode;

  @override
  List<Object?> get props => [orderCode];
}

final class OrderProcessPaymentSuccess extends OrderProcessState {
  const OrderProcessPaymentSuccess();
}

final class OrderProcessLoadFailed extends OrderProcessState {
  const OrderProcessLoadFailed({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
