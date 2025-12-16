part of 'order_detail_bloc.dart';

sealed class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();

  @override
  List<Object> get props => [];
}

final class OrderDetailRequested extends OrderDetailEvent {
  final String authToken;
  final String orderCode;

  const OrderDetailRequested(this.authToken, this.orderCode);
}

final class OrderDetailCleared extends OrderDetailEvent {
  const OrderDetailCleared();
}
