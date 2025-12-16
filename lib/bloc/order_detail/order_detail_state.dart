part of 'order_detail_bloc.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object?> get props => [];
}

final class OrderDetailInitial extends OrderDetailState {}

final class OrderDetailLoading extends OrderDetailState {}

final class OrderDetailLoadSuccess extends OrderDetailState {
  const OrderDetailLoadSuccess({required this.data});

  final Order data;

  @override
  List<Object?> get props => [data];
}

final class OrderDetailLoadFailed extends OrderDetailState {
  const OrderDetailLoadFailed({
    required this.errorMessage
  });

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
