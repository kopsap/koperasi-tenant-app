part of 'order_process_bloc.dart';

sealed class OrderProcessEvent extends Equatable {
  const OrderProcessEvent();

  @override
  List<Object> get props => [];
}

final class OrderProcessCreate extends OrderProcessEvent {
  final OrderCreateRequest request;

  const OrderProcessCreate(this.request);
}

final class OrderProcessPayment extends OrderProcessEvent {
  final String orderCode;
  final OrderPaymentRequest request;

  const OrderProcessPayment(this.orderCode, this.request);
}

final class OrderProcessCleared extends OrderProcessEvent {
  const OrderProcessCleared();
}
