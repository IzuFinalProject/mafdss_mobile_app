import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:user_repository/utility/util.dart';
import 'models/models.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    var token = await Util.getToken("token");
    token = token!;
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    await dotenv.load();
    final URL = dotenv.get("API_USER_URL", fallback: "API_USER_URL not found");
    var response = await http.get(
      Uri.parse(URL),
      headers: headers,
    );
    if (response.statusCode == 200) {
      final user = User.fromDatabaseJson(json.decode(response.body));
      return user;
    } else {
      throw Exception(json.decode(response.body));
    }
  }
}
