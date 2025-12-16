part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderLoadSuccess extends OrderState {
  const OrderLoadSuccess({required this.data});

  final List<Order> data;

  @override
  List<Object?> get props => [data];
}

final class OrderLoadFailed extends OrderState {
  const OrderLoadFailed({
    required this.errorMessage
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
