// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPaymentRequest _$OrderPaymentRequestFromJson(Map<String, dynamic> json) =>
    OrderPaymentRequest(
      authToken: json['authToken'] as String,
      isCash: (json['isCash'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$OrderPaymentRequestToJson(
        OrderPaymentRequest instance) =>
    <String, dynamic>{
      'authToken': instance.authToken,
      'isCash': instance.isCash,
    };
