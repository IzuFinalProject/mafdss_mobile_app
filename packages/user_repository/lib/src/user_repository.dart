import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:user_repository/utility/util.dart';
import 'models/models.dart';
class UserNotFoundException implements Exception {}

class UserRepository {
  User? _user;
User? get userGetter {
    return _user;
  }
 Future<bool> uploadUserImage(dynamic images) async {
   print("Uploading Image!");
   return true;
 }
  Future<User?> getUser() async {
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
    ).timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      return User.fromDatabaseJson(json.decode(response.body));
    } else {
       throw UserNotFoundException();
    }
  }
  Future<bool> editProfilePicture(dynamic profile) async {
    var token = await Util.getToken("token");
    token = token!;
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    await dotenv.load();
    final API_FILE_URL = dotenv.get("API_FILE_URL", fallback: "API_FILE_URL not found");
    var response = await http.put(
      Uri.parse(API_FILE_URL),
      headers: headers,
      body:  {
        "file": profile
      }
    ).timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      print(json.decode(response.body)[0]);
      final pro =  Profile.fromDatabaseJson(json.decode(response.body)[0]);
      print(pro.toString());
      return pro;
    } else {
       throw UserNotFoundException();
    }
  }

  Future<Profile> editProfile(Profile profile) async {
    var token = await Util.getToken("token");
    token = token!;
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    await dotenv.load();
    final BASE_URL = dotenv.get("BASE_URL", fallback: "BASE_URL not found");
    final PROFILE_URL = dotenv.get("API_USER_URL", fallback: "API_USER_URL not found");
    var response = await http.put(
      Uri.parse(PROFILE_URL),
      headers: headers,
      body: profile.toDatabaseJson()
    ).timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      print(json.decode(response.body)[0]);
      final pro =  Profile.fromDatabaseJson(json.decode(response.body)[0]);
      print(pro.toString());
      return pro;
    } else {
       throw UserNotFoundException();
    }

  }
  Future<Profile?> getProfile() async {
   var token = await Util.getToken("token");
    token = token!;
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    await dotenv.load();
    final BASE_URL = dotenv.get("BASE_URL", fallback: "BASE_URL not found");
    final PROFILE_URL = dotenv.get("PROFILE_URL", fallback: "PROFILE_URL not found");
    var response = await http.get(
      Uri.parse(PROFILE_URL),
      headers: headers,
    ).timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      final pro =  Profile.fromDatabaseJson(json.decode(response.body));
      print(pro.toString());
      return pro;
    } else {
       throw UserNotFoundException();
    } 
  }
}
