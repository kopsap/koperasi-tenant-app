import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  String cardId;
  String pin;

  AuthRequest({required this.cardId, required this.pin});

  bool allowLogin() {
    return cardId != "" && pin != "";
  }

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
