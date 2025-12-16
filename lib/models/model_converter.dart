import 'package:json_annotation/json_annotation.dart';

class StringIntConverter implements JsonConverter<int, String> {
  const StringIntConverter();

  @override
  int fromJson(String json) => int.tryParse(json) ?? 0;

  @override
  String toJson(int json) => json.toString();
}

class StringNumConverter implements JsonConverter<num, String> {
  const StringNumConverter();

  @override
  num fromJson(String json) => num.tryParse(json) ?? 0.0;

  @override
  String toJson(num json) => json.toString();
}

class StringDoubleConverter implements JsonConverter<double, String> {
  const StringDoubleConverter();

  @override
  double fromJson(String json) => double.tryParse(json) ?? 0.0;

  @override
  String toJson(double json) => json.toString();
}

// class ModelToJson implements JsonConverter<List, List> {
//   const ModelToJson();

//   @override
//   List toJson(List json) => json.map((Object e) => e.toJson());
// }
