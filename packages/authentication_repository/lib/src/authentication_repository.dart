import 'dart:async';
import 'package:authentication_repository/utility/util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:user_repository/user_repository.dart';



enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    final URL = dotenv.get("API_TOKEN_URL",fallback: "API_TOKEN_URL not found" );
    var response = await http.post(
      Uri.parse(URL),
      headers: {"Content-Type": "application/json"},
       body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
    );
    if (response.statusCode == 200) {
      final token = Token.fromJson(json.decode(response.body)).token;
      print(token);
      await Util.setToken(token);
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      print(json.decode(response.body).toString());
      throw Exception(json.decode(response.body));
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
