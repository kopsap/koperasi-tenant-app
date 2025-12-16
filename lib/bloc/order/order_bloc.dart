import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koperasitenantapp/models/order/order.dart';
import 'package:koperasitenantapp/models/order/order_list_request.dart';
import 'package:koperasitenantapp/service/api_service.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({required ApiService apiService})
    : _apiService = apiService,
      super(OrderInitial()) {
    on<OrderRequested>(_onOrderRequested);
    on<OrderCleared>(_onOrderCleared);
  }

  final ApiService _apiService;

  void _onOrderRequested(OrderRequested event, Emitter<OrderState> emit) async {
    emit(OrderLoading());

    try {
      final response = await _apiService.getOrders(
        authToken: event.authToken,
        request: event.request,
      );

      if (response.response.statusCode != 200) {
        throw Exception(response.response.statusMessage);
      }

      if (response.data.isSuccess()) {
        // emit(OrderLoadFailed(errorMessage: "Test Refresh!~"));
        emit(
          OrderLoadSuccess(
            data:
                (response.data.data as List).map((item) {
                  return Order.fromJson(item);
                }).toList(),
          ),
        );
      } else {
        throw Exception(response.data.message);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.statusMessage;
      emit(
        OrderLoadFailed(
          errorMessage: errorMessage ?? "Gagal mendapatkan data pesanan!",
        ),
      );
    } catch (e) {
      emit(OrderLoadFailed(errorMessage: "Gagal mendapatkan data pesanan!"));
    }
  }

  void _onOrderCleared(OrderCleared event, Emitter<OrderState> emit) async {
    // emit(OrderLoading());
    emit(OrderLoadSuccess(data: []));
  }
}
