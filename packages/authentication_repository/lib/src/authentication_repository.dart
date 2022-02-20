import 'dart:async';
import 'package:authentication_repository/utility/util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_repository/firebase_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }


  Future<void> registerDevice({
    required String? deviceToken,
    required String? token,
  }) async {
    final URL =
        dotenv.get("API_DEVICES_URL", fallback: "API_DEVICES_URL not found");
    try {
      final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

      final response = await http.post(
        Uri.parse(URL),
        headers: headers,
        body: jsonEncode(<String, String>{
          'registration_id': deviceToken??"",
          'type': "android",
          // TODO()  only android is being registered
        }),
      ).timeout(const Duration(seconds: 15));
    } on TimeoutException catch (e) {
      print('Timeout');
      throw Exception("Server TimeOut");
    } on Error catch (e) {
      print('Error: $e');
      throw Exception(json.decode(e.toString()));
    }
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    final URL =
        dotenv.get("API_TOKEN_URL", fallback: "API_TOKEN_URL not found");

    try {
      var response = await http.post(
        Uri.parse(URL),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final token = Token.fromJson(json.decode(response.body)).token;
        print(token);
        await Util.setToken(token);
        final firebaseToken = await FirebaseMessagingService().getToken();
        print(jsonEncode({"firebaseToken":firebaseToken,"token":token}));
        await registerDevice(deviceToken: firebaseToken,token: token);
        _controller.add(AuthenticationStatus.authenticated);
      } else {
        print(json.decode(response.body).toString());
        throw Exception(json.decode(response.body));
      }
    } on TimeoutException catch (e) {
      print('Timeout');
      throw Exception("Server TimeOut");
    } on Error catch (e) {
      print('Error: $e');
      throw Exception(json.decode(e.toString()));
    }
  }

  Future<void> register({
    required String email,
    required String firstname,
    required String lastname,
    required String password,
    required String re_password,
  }) async {
    final URL = dotenv.get("API_USER_URL", fallback: "API_USER_URL not found");
    var response = await http.post(
      Uri.parse(URL),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'first_name': firstname,
        'last_name': lastname,
        'username': lastname + "@" + firstname,
      }),
    ).timeout(const Duration(seconds: 10));
    if (response.statusCode == 201) {
      logIn(username: lastname + "@" + firstname, password: password);
    } else {
      print(response.body);
      throw Exception(json.decode(response.body));
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }
  void dispose() => _controller.close();
}
