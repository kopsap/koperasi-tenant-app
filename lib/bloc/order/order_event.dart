part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

final class OrderRequested extends OrderEvent {
  final String authToken;
  final OrderListRequest request;

  const OrderRequested(this.authToken, this.request);
}

final class OrderCleared extends OrderEvent {
  const OrderCleared();
}
