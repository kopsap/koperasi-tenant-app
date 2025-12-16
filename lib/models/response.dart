import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class ApiResponse {
  const ApiResponse({this.errorCode = -1, this.message = "", this.data = null});

  final int errorCode;
  final String message;
  final data;

  bool isSuccess() {
    return errorCode == 0;
  }

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
