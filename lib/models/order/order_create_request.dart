import 'package:json_annotation/json_annotation.dart';
import 'package:koperasitenantapp/models/order/order_item.dart';

part 'order_create_request.g.dart';

@JsonSerializable()
class OrderCreateRequest {
  OrderCreateRequest({
    required this.authToken,
    required this.orderItems,
    this.orderNotes = "",
  });

  String authToken;
  List<OrderItem> orderItems;
  String orderNotes;

  factory OrderCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateRequestToJson(this);
}
