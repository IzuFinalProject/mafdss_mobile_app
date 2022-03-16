import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class File extends Equatable {
  File( {required this.url});
  final String url;

   @override
  List<Object> get props => [];
  static var empty = File(url: '');
factory File.fromDatabaseJson(Map<String, dynamic> data)    {
    try {

      return File(
        url: data['file'] 
      );
    } catch (e) {
      return empty;
    }
  }

  Map<String, dynamic> toDatabaseJson() => {
        "url": this.url,
      };
}

class Profile extends Equatable {
  Profile(
      {required this.username, required this.email, required this.fileList});

  final String username;
  final String email;
  List<File> fileList;

  @override
  List<Object> get props => [];
  static var empty = Profile(username: '', email: '', fileList: []);

  factory Profile.fromDatabaseJson(Map<String, dynamic> data)    {
    try {
      final pro =  Profile(
        username: data['username'] ,
        email: data['email'] ,
        fileList: List<File>.from(data['fileList'].map(
              (item) =>File.fromDatabaseJson(item))),
      );
     
      return pro;
    } catch (e) {
      print(e);
      return empty;
    }
  }

  Map<String, dynamic> toDatabaseJson() => {
        "username": this.username,
        "email": this.email,
        "fileList": this.fileList,
      };
}
