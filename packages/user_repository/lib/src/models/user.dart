import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.username,
      required this.email,
      required this.first_name,
      required this.last_name
      });

  final String id;
  final String username;
  final String first_name;
  final String last_name;
  final String email;

  @override
  List<Object> get props => [id];

  static const empty =
      User(id: '',  username: '', last_name: '', first_name: '',email: '');

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        id: data['username'],
        username: data['username'],
        first_name: data['first_name'],
        last_name: data['last_name'],
        email: data['email'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.username,
        "username": this.username,
        "first_name": this.first_name,
        "last_name": this.last_name,
        "email": this.email,
      };


}
