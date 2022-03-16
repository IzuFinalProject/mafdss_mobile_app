import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/utility/util.dart';
import 'models/models.dart';
import 'models/notfication.dart';

class UserNotFoundException implements Exception {}
class NotificationNotFound implements Exception {}

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
    var response = await http
        .get(
          Uri.parse(URL),
          headers: headers,
        )
        .timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      return User.fromDatabaseJson(json.decode(response.body));
    } else {
      throw UserNotFoundException();
    }
  }

  Future<bool> editProfilePicture(List<XFile> pickedFiles) async {
    var token = await Util.getToken("token");
    token = token!;
    await dotenv.load();
    final API_FILE_URL =
        dotenv.get("API_FILE_URL", fallback: "API_FILE_URL not found");
    try {
      var uri = Uri.parse(API_FILE_URL);
       var request = new http.MultipartRequest("POST", uri);
      pickedFiles.forEach((file) async{
        var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(file.path));
      request.files.add(multipartFile);
      });

    
      
      request.fields.addAll({
        "user_id":"1",
        "is_profile":"2"
      });
      request.headers['authorization'] = 'Bearer $token';
      request.send().then((response) {
        if (response.statusCode == 200) print("Uploaded!");
        else
         throw UserNotFoundException();
      });
      return true;
    } catch (e) {
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
    final PROFILE_URL =
        dotenv.get("API_USER_URL", fallback: "API_USER_URL not found");
    var response = await http
        .put(Uri.parse(PROFILE_URL),
            headers: headers, body: profile.toDatabaseJson())
        .timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      print(json.decode(response.body)[0]);
      final pro = Profile.fromDatabaseJson(json.decode(response.body)[0]);
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
    final PROFILE_URL =
        dotenv.get("PROFILE_URL", fallback: "PROFILE_URL not found");
    var response = await http
        .get(
          Uri.parse(PROFILE_URL),
          headers: headers,
        )
        .timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      final pro = Profile.fromDatabaseJson(json.decode(response.body));
      print(pro.toDatabaseJson());
      await dotenv.load();
      pro.fileList = pro.fileList.map((e) => File(url: BASE_URL+e.url)).toList();
      return pro;
    } else {
      throw UserNotFoundException();
    }
  }
  
  Future<List<Notification>> getNotfications() async {
    var token = await Util.getToken("token");
    token = token!;
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    await dotenv.load();
    final BASE_URL = dotenv.get("BASE_URL", fallback: "BASE_URL not found");
    final NOTIFICATION_URL =
        dotenv.get("NOTIFICATION_URL", fallback: "NOTIFICATION_URL not found");
    var response = await http
        .get(
          Uri.parse(NOTIFICATION_URL),
          headers: headers,
        )
        .timeout(const Duration(seconds: 15));
    if (response.statusCode == 200) {
      final list = List<Notification>.from(json.decode(response.body).map(
              (item) => Notification.fromJson(item)));
      print(list);
      return list;
    } else {
      throw NotificationNotFound();
    }
  }
}
