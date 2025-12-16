import 'package:dio/dio.dart';
import 'package:koperasitenantapp/service/api_hash.dart';

class ApiMiddleware extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var requestData = options.data ?? options.queryParameters;
    requestData ??= {};

    final checker = ApiRequestProcess(request: requestData);

    if (options.data != null) {
      options.data = checker.processedRequest;
    } else {
      options.queryParameters = checker.processedRequest;
    }

    super.onRequest(options, handler);
  }
}
