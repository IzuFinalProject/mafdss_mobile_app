import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  Profile(
      {required this.username,
      required this.email});

  final String username;
  final String email;

  @override
  List<Object> get props => [];

  static var empty = Profile(username: '', email: '');

  factory Profile.fromDatabaseJson(Map<String, dynamic> data) => Profile(
        username: data['username'] ?? "",
        email: data['email'] ?? "",
      );

  Map<String, dynamic> toDatabaseJson() => {
        "username": this.username,
        "email": this.email,
      };
}
