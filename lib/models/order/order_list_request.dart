import 'package:json_annotation/json_annotation.dart';

part 'order_list_request.g.dart';

@JsonSerializable()
class OrderListRequest {
  OrderListRequest({
    this.startDate,
    this.endDate,
    this.status = 1,
    this.search,
    this.start,
    this.limit,
  });

  DateTime? startDate;
  DateTime? endDate;

  int? status;
  String? search;
  int? start;
  int? limit;

  factory OrderListRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListRequestToJson(this);
}
