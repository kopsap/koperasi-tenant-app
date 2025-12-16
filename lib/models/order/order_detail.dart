import 'package:json_annotation/json_annotation.dart';
import 'package:koperasitenantapp/models/model_converter.dart';

part 'order_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderDetail {
  const OrderDetail({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.productCode,
    this.productName,
  });

  final int? id;
  final int? orderId;

  final int? productId;
  final int? quantity;

  @StringDoubleConverter()
  final double? price;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? productCode;
  final String? productName;

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);
}
