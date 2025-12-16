import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koperasitenantapp/models/order/order.dart';
import 'package:koperasitenantapp/service/api_service.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailBloc({required ApiService apiService})
    : _apiService = apiService,
      super(OrderDetailInitial()) {
    on<OrderDetailRequested>(_onOrderDetailRequested);
    on<OrderDetailCleared>(_onOrderDetailCleared);
  }

  final ApiService _apiService;

  void _onOrderDetailRequested(
    OrderDetailRequested event,
    Emitter<OrderDetailState> emit,
  ) async {
    emit(OrderDetailLoading());

    try {
      final response = await _apiService.getOrder(authToken: event.authToken, orderCode: event.orderCode);

      if (response.response.statusCode != 200) {
        throw Exception(response.response.statusMessage);
      }

      if (response.data.isSuccess()) {
        // emit(OrderDetailLoadFailed(errorMessage: "Test Refresh!~"));
        emit(OrderDetailLoadSuccess(data: Order.fromJson(response.data.data)));
      } else {
        throw Exception(response.data.message);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.statusMessage;
      emit(
        OrderDetailLoadFailed(
          errorMessage: errorMessage ?? "Gagal mendapatkan data pesanan!",
        ),
      );
    } catch (e) {
      emit(
        OrderDetailLoadFailed(errorMessage: "Gagal mendapatkan data pesanan!"),
      );
    }
  }

  void _onOrderDetailCleared(
    OrderDetailCleared event,
    Emitter<OrderDetailState> emit,
  ) async {
    // emit(OrderDetailLoading());
    emit(OrderDetailLoadSuccess(data: Order()));
  }
}
