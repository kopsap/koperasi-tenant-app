// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      id: (json['id'] as num?)?.toInt(),
      divisionId: (json['division_id'] as num?)?.toInt(),
      divisionName: json['division_name'] as String?,
      workerId: json['worker_id'] as String?,
      workerName: json['worker_name'] as String?,
      balance: _$JsonConverterFromJson<String, double>(
          json['balance'], const StringDoubleConverter().fromJson),
      wages: _$JsonConverterFromJson<String, double>(
          json['wages'], const StringDoubleConverter().fromJson),
      cardId: json['card_id'] as String?,
      billValue: _$JsonConverterFromJson<String, double>(
          json['bill_value'], const StringDoubleConverter().fromJson),
      status: (json['status'] as num?)?.toInt(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      authToken: json['authToken'] as String?,
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'id': instance.id,
      'division_id': instance.divisionId,
      'division_name': instance.divisionName,
      'worker_id': instance.workerId,
      'worker_name': instance.workerName,
      'balance': _$JsonConverterToJson<String, double>(
          instance.balance, const StringDoubleConverter().toJson),
      'wages': _$JsonConverterToJson<String, double>(
          instance.wages, const StringDoubleConverter().toJson),
      'card_id': instance.cardId,
      'bill_value': _$JsonConverterToJson<String, double>(
          instance.billValue, const StringDoubleConverter().toJson),
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'authToken': instance.authToken,
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
