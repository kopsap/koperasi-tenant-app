import 'package:json_annotation/json_annotation.dart';

part 'order_payment_request.g.dart';

@JsonSerializable()
class OrderPaymentRequest {
  String authToken;
  int isCash;

  OrderPaymentRequest({required this.authToken, this.isCash = 0});

  factory OrderPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderPaymentRequestToJson(this);
}
