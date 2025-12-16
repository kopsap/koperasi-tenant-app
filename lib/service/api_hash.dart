import 'dart:convert';

import 'package:crypto/crypto.dart';

class ApiRequestProcess {
  ApiRequestProcess({
    this.request = const {},
    this.secretKey = "k0p3R4s1-c0R3",
    // this.secretKey = "azBwM1I0czEtYzBSMw==",
  }) {
    _checkRequest();
    _generateHash();
    processedRequest['hash'] = hash;
  }

  final Map request;
  final String secretKey;
  Map<String, dynamic> processedRequest = {};
  String hash = "";

  // Check if there is empty value, then if it is really empty, then dont include in request
  void _checkRequest() {
    request.forEach((k, v) {
      if (v != null && v != "") {
        processedRequest[k] = v;
      }
    });
  }

  String _serialize() {
    // Sort keys
    final keys = processedRequest.keys.toList();
    keys.sort((a, b) => a.toString().compareTo(b.toString()));

    // Serialize
    final serializedRequest = keys
        .map((key) {
          return "$key=${processedRequest[key]}";
        })
        .join("&");

    return serializedRequest;
  }

  void _hashString(String str) {
    // Concat with secret key and hash
    final bytes = utf8.encode("$secretKey$str$secretKey");
    hash = sha256.convert(bytes).toString();
  }

  /*
    1. Sort request by key
    2. Serialize
    3. Concat it with secret key on both sides
    4. Hash with SHA 256
  */
  void _generateHash() {
    final serialized = _serialize();
    _hashString(serialized);
  }
}
