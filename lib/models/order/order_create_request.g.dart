// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_create_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateRequest _$OrderCreateRequestFromJson(Map<String, dynamic> json) =>
    OrderCreateRequest(
      authToken: json['authToken'] as String,
      orderItems:
          (json['orderItems'] as List<dynamic>)
              .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList(),
      orderNotes: json['orderNotes'] as String? ?? "",
    );

Map<String, dynamic> _$OrderCreateRequestToJson(OrderCreateRequest instance) =>
    <String, dynamic>{
      'authToken': instance.authToken,
      'orderItems': instance.orderItems.map((e) {
        return e.toJson();
      }).toList().toString(),
      'orderNotes': instance.orderNotes,
    };
