import 'package:dio/dio.dart';

import 'package:koperasitenantapp/service/api_middleware.dart';

class DioConfig {
  static Dio getDio() {
    final dio = Dio();
    dio.interceptors.add(ApiMiddleware());
    dio.options.connectTimeout = const Duration(seconds: 10);
    return dio;
  }
}
