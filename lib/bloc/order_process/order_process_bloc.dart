import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koperasitenantapp/models/order/order_create_request.dart';
import 'package:koperasitenantapp/models/order/order_payment_request.dart';
import 'package:koperasitenantapp/service/api_service.dart';

part 'order_process_event.dart';
part 'order_process_state.dart';

class OrderProcessBloc extends Bloc<OrderProcessEvent, OrderProcessState> {
  OrderProcessBloc({required ApiService apiService})
    : _apiService = apiService,
      super(OrderProcessInitial()) {
    on<OrderProcessCreate>(_onOrderProcessCreate);
    on<OrderProcessPayment>(_onOrderProcessPayment);
  }

  final ApiService _apiService;

  void _onOrderProcessCreate(
    OrderProcessCreate event,
    Emitter<OrderProcessState> emit,
  ) async {
    emit(OrderProcessLoading());

    try {
      print("Request: " + event.request.toJson().toString());
      final response = await _apiService.createOrder(
        authToken: event.request.authToken,
        request: event.request,
      );

      if (response.response.statusCode != 200) {
        throw Exception(response.response.statusMessage);
      }

      print("Response: " + response.data.toJson().toString());
      if (response.data.isSuccess()) {
        emit(
          OrderProcessCreateSuccess(orderCode: response.data.data["orderCode"]),
        );
      } else {
        throw Exception(response.data.message);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.statusMessage;
      print("DioException: " + e.response.toString());
      emit(
        OrderProcessLoadFailed(
          errorMessage: errorMessage ?? "Gagal membuat transaksi!",
        ),
      );
    } catch (e) {
      print("GeneralException: " + e.toString());
      emit(OrderProcessLoadFailed(errorMessage: "Gagal membuat transaksi!"));
    }
  }

  void _onOrderProcessPayment(
    OrderProcessPayment event,
    Emitter<OrderProcessState> emit,
  ) async {
    emit(OrderProcessLoading());

    try {
      final response = await _apiService.orderPayment(
        authToken: event.request.authToken,
        orderCode: event.orderCode,
        request: event.request,
      );

      if (response.response.statusCode != 200) {
        throw Exception(response.response.statusMessage);
      }

      if (response.data.isSuccess()) {
        emit(OrderProcessPaymentSuccess());
      } else {
        throw Exception(response.data.message);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.statusMessage;
      emit(
        OrderProcessLoadFailed(
          errorMessage: errorMessage ?? "Gagal melakukan pembayaran!",
        ),
      );
    } catch (e) {
      emit(OrderProcessLoadFailed(errorMessage: "Gagal melakukan pembayaran!"));
    }
  }
}
