import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:koperasitenantapp/models/auth/auth.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

  static const String _jwtKey = "token";
  // static const String _merchantKey = "merchantCode";
  static const String _credentialKey = "credentials";

  // Token
  Future<void> storeToken(String token) async {
    await _storage.write(key: _jwtKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _jwtKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _jwtKey);
  }

  // Merchant Code
  // Future<void> storeMerchantCode(String code) async {
  //   await _storage.write(key: _merchantKey, value: code);
  // }

  // Future<String?> getMerchantCode() async {
  //   return await _storage.read(key: _merchantKey);
  // }

  // Future<void> deleteMerchantCode() async {
  //   await _storage.delete(key: _merchantKey);
  // }

  // Store the whole data instead
  Future<void> storeCredentials(Auth data) async {
    await _storage.write(key: _credentialKey, value: jsonEncode(data.toJson()));
  }

  Future<Auth> getCredentials() async {
    String? creds = await _storage.read(key: _credentialKey);
    Map<String, dynamic> parsed = jsonDecode(creds!);

    return Auth.fromJson(parsed);
  }

  Future<void> deleteCredentials() async {
    await _storage.delete(key: _credentialKey);
  }
}
