import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier {
  final String _urlBase = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyD-MhJQm6ATapD_bGt8PZbJPcq2ObHjtGo';

  final storage = const FlutterSecureStorage();

  Future<String?> registerUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url =
        Uri.https(_urlBase, '/v1/accounts:signUp', {'key': _firebaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeMap = json.decode(resp.body);

    if (decodeMap.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodeMap['idToken']);
      return null;
    } else {
      return decodeMap['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.https(
        _urlBase, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeMap = json.decode(resp.body);

    if (decodeMap.containsKey('idToken')) {
      // await storage.write(key: 'token', value: decodeMap['idToken']);
      return null;
    } else {
      return decodeMap['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
