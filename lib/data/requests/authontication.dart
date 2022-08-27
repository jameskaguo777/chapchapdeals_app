import 'package:shared_preferences/shared_preferences.dart';

class AuthonticationRequests {
  static Future<bool> storeAuthToken(String token) async {
    return (await SharedPreferences.getInstance())
        .setString('auth-token', token);
  }

  static Future<String> getToken() async {
    return (await SharedPreferences.getInstance()).getString('auth-token') ?? '';
  }
}
