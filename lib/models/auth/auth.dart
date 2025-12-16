import 'package:json_annotation/json_annotation.dart';
import 'package:koperasitenantapp/models/model_converter.dart';

part 'auth.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Auth {
  const Auth({
    this.id,
    this.divisionId,
    this.divisionName,
    this.workerId,
    this.workerName,
    this.balance,
    this.wages,
    this.cardId,
    this.billValue,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.authToken,
  });

  // @StringIntConverter()
  final int? id;

  // @StringIntConverter()
  final int? divisionId;
  final String? divisionName;

  final String? workerId;
  final String? workerName;

  @StringDoubleConverter()
  final double? balance;

  @StringDoubleConverter()
  final double? wages;

  final String? cardId;

  @StringDoubleConverter()
  final double? billValue;

  // @StringIntConverter()
  final int? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  @JsonKey(name: "authToken")
  final String? authToken;

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}
