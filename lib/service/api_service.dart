import 'package:koperasitenantapp/models/auth/auth_request.dart';
import 'package:koperasitenantapp/models/order/order_create_request.dart';
import 'package:koperasitenantapp/models/order/order_list_request.dart';
import 'package:koperasitenantapp/models/order/order_payment_request.dart';
import 'package:koperasitenantapp/models/response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://devapi.koperasi-sap.com/api/v1/")
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  // Auth
  @POST('tenant/login')
  Future<HttpResponse<ApiResponse>> authLogin({
    @Body() required AuthRequest request,
  });

  @POST('auth/auth-card')
  Future<HttpResponse<ApiResponse>> authCard({
    @Body() required AuthRequest request,
  });

  // Orders
  @GET('tenant/order')
  Future<HttpResponse<ApiResponse>> getOrders({
    @Header('Authorization') required String authToken,
    @Queries() required OrderListRequest request,
  });

  @GET('tenant/order/{orderCode}')
  Future<HttpResponse<ApiResponse>> getOrder({
    @Header('Authorization') required String authToken,
    @Path('orderCode') required String orderCode,
  });

  @POST('tenant/order/create')
  Future<HttpResponse<ApiResponse>> createOrder({
    @Header('Authorization') required String authToken,
    @Body() required OrderCreateRequest request,
  });

  @POST('tenant/order/payment/{orderCode}')
  Future<HttpResponse<ApiResponse>> orderPayment({
    @Header('Authorization') required String authToken,
    @Path('orderCode') required String orderCode,
    @Body() required OrderPaymentRequest request,
  });

  @GET('order/get-receipt/{orderCode}')
  Future<HttpResponse<ApiResponse>> getOrderReceipt({
    @Path('orderCode') required String orderCode,
  });
}
