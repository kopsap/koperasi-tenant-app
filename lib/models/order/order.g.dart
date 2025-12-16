// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: (json['id'] as num?)?.toInt(),
      orderCode: json['order_code'] as String?,
      workerId: json['worker_id'] as String?,
      orderValue: _$JsonConverterFromJson<String, double>(
          json['order_value'], const StringDoubleConverter().fromJson),
      adminFee: _$JsonConverterFromJson<String, double>(
          json['admin_fee'], const StringDoubleConverter().fromJson),
      status: (json['status'] as num?)?.toInt(),
      statusMessage: json['status_message'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      orderNotes: json['order_notes'] as String?,
      isCash: (json['is_cash'] as num?)?.toInt(),
      workerName: json['worker_name'] as String?,
      detail: (json['detail'] as List<dynamic>?)
          ?.map((e) => OrderDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'order_code': instance.orderCode,
      'worker_id': instance.workerId,
      'order_value': _$JsonConverterToJson<String, double>(
          instance.orderValue, const StringDoubleConverter().toJson),
      'admin_fee': _$JsonConverterToJson<String, double>(
          instance.adminFee, const StringDoubleConverter().toJson),
      'status': instance.status,
      'status_message': instance.statusMessage,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'order_notes': instance.orderNotes,
      'is_cash': instance.isCash,
      'worker_name': instance.workerName,
      'detail': instance.detail,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
