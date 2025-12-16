// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderListRequest _$OrderListRequestFromJson(Map<String, dynamic> json) =>
    OrderListRequest(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      status: (json['status'] as num?)?.toInt() ?? 1,
      search: json['search'] as String?,
      start: (json['start'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderListRequestToJson(OrderListRequest instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'status': instance.status,
      'search': instance.search,
      'start': instance.start,
      'limit': instance.limit,
    };
