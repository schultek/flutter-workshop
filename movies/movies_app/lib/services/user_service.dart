import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  static AuthService instance = AuthService();
  var domain = "http://192.168.0.184:8080/";

  String? _token;
  String? get token => _token;
  String? _username;
  String get username => _username!;

  Future<bool> login(String username, String password) async {
    return _signIn(username, password, 'login');
  }

  Future<bool> register(String username, String password) async {
    return _signIn(username, password, 'register');
  }

  Future<bool> _signIn(
      String username, String password, String endpoint) async {
    // construct url
    var url = Uri.parse(domain + 'auth/$endpoint');
    // send request
    var response = await http.post(
      url,
      body: jsonEncode({'username': username, 'password': password}),
    );
    // decode response
    if (response.statusCode != 200) {
      return false;
    }
    _token = response.body;
    _username = username;
    return true;
  }
}
