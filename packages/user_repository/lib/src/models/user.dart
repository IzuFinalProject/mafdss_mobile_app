import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.username,
      required this.email,
      required this.first_name,
      required this.last_name,
      required this.profileImage
      });

  final String id;
  final String username;
  final String first_name;
  final String last_name;
  final String profileImage;
  final String email;

  @override
  List<Object> get props => [id];

  static const empty =
      User(id: '',  username: '', last_name: '', first_name: '',profileImage:'',email: '');

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        id: data['username'],
        username: data['username'],
        first_name: data['first_name'],
        last_name: data['last_name'],
        profileImage: "https://www.shareicon.net/data/128x128/2016/07/26/802043_man_512x512.png",
        email: data['email'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.username,
        "username": this.username,
        "first_name": this.first_name,
        "last_name": this.last_name,
        "profileImage": this.profileImage,
        "email": this.email,
      };


}
