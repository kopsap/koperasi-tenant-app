import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koperasitenantapp/models/auth/auth_request.dart';
import 'package:koperasitenantapp/models/auth/auth.dart';
import 'package:koperasitenantapp/models/auth/auth_request.dart';
import 'package:koperasitenantapp/service/api_service.dart';

part 'auth_payment_event.dart';
part 'auth_payment_state.dart';

class AuthPaymentBloc extends Bloc<AuthPaymentEvent, AuthPaymentState> {
  AuthPaymentBloc({required ApiService apiService})
    : _apiService = apiService,
      super(AuthPaymentInitial()) {
    on<AuthPaymentRequested>(_onAuthPaymentRequest);
  }

  final ApiService _apiService;

  void _onAuthPaymentRequest(AuthPaymentRequested event, Emitter<AuthPaymentState> emit) async {
    emit(AuthPaymentLoading());

    try {
      final response = await _apiService.authCard(request: event.request);
      
      if (response.response.statusCode != 200) {
        throw Exception(response.response.statusMessage);
      }

      if (response.data.isSuccess()) {
        emit(AuthPaymentLoadSuccess(data: Auth.fromJson(response.data.data)));
      } else {
        throw Exception(response.data.message);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.statusMessage;
      print("DioException: " + e.toString());
      emit(AuthPaymentLoadFailed(errorMessage: errorMessage ?? "Otorisasi gagal!"));
    } catch (e) {
      print("GeneralException: " + e.toString());
      emit(AuthPaymentLoadFailed(errorMessage: "Otorisasi gagal!"));
    }
  }
}
