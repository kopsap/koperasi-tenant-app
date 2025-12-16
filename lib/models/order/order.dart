import 'package:json_annotation/json_annotation.dart';
import 'package:koperasitenantapp/models/model_converter.dart';
import 'package:koperasitenantapp/models/order/order_detail.dart';

part 'order.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Order {
  const Order({
    this.id,
    this.orderCode,
    this.workerId,
    this.orderValue,
    this.adminFee,
    this.status,
    this.statusMessage,
    this.createdAt,
    this.updatedAt,
    this.orderNotes,
    this.isCash,
    this.workerName,
    this.detail,
  });

  final int? id;
  final String? orderCode;
  final String? workerId;

  @StringDoubleConverter()
  final double? orderValue;
  @StringDoubleConverter()
  final double? adminFee;

  final int? status;
  final String? statusMessage;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? orderNotes;
  final int? isCash;

  final String? workerName;

  final List<OrderDetail>? detail;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
