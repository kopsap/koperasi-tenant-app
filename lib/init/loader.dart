import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:koperasitenantapp/bloc/auth/auth_bloc.dart';
import 'package:koperasitenantapp/bloc/auth_payment/auth_payment_bloc.dart';
import 'package:koperasitenantapp/bloc/order/order_bloc.dart';
import 'package:koperasitenantapp/bloc/order_detail/order_detail_bloc.dart';
import 'package:koperasitenantapp/bloc/order_process/order_process_bloc.dart';
import 'package:koperasitenantapp/init/dio_config.dart';
import 'package:koperasitenantapp/service/api_service.dart';
import 'package:koperasitenantapp/init/util/nfc.dart';
import 'package:koperasitenantapp/service/storage.dart';

final getIt = GetIt.instance;

// Load dependencies here to enhance resource and memory usage
void initializeDepedencies() {
  // Dio Config
  getIt.registerLazySingleton(() => DioConfig.getDio());

  // API Service
  getIt.registerLazySingleton(() => ApiService(getIt<Dio>()));

  // Storage Service
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton(
    () => SecureStorage(getIt<FlutterSecureStorage>()),
  );

  // Blocs
  getIt.registerLazySingleton(() => AuthBloc(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton(() => AuthPaymentBloc(apiService: getIt<ApiService>()));
  
  getIt.registerLazySingleton(() => OrderBloc(apiService: getIt<ApiService>()));
  getIt.registerLazySingleton(
    () => OrderDetailBloc(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton(
    () => OrderProcessBloc(apiService: getIt<ApiService>()),
  );

  getIt.registerLazySingleton(() => NFCReader());
}
