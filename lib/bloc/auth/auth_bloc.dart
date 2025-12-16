import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:koperasitenantapp/models/auth/auth_request.dart';
import 'package:koperasitenantapp/models/auth/auth.dart';
import 'package:koperasitenantapp/models/auth/auth_request.dart';
import 'package:koperasitenantapp/service/api_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required ApiService apiService})
    : _apiService = apiService,
      super(AuthInitial()) {
    on<AuthLogin>(_onAuthLogin);
    on<AuthLogout>(_onAuthLogout);
  }

  final ApiService _apiService;

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await _apiService.authLogin(request: event.request);
      // print("Request: " + event.request.toJson().toString());
      // print("Response: " + response.data.toJson().toString());
      if (response.response.statusCode != 200) {
        throw Exception(response.response.statusMessage);
      }

      if (response.data.isSuccess()) {
        emit(AuthLoadSuccess(data: Auth.fromJson(response.data.data)));
      } else {
        throw Exception(response.data.message);
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.statusMessage;
      print("DioException: " + e.toString());
      emit(AuthLoadFailed(errorMessage: errorMessage ?? "Login gagal!"));
    } catch (e) {
      print("GeneralException: " + e.toString());
      emit(AuthLoadFailed(errorMessage: "Login gagal!"));
    }
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    emit(AuthInitial());
  }
}
