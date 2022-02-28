part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetUser extends ProfileEvent {
  GetUser();
}
class EditUser extends ProfileEvent {
  final String userName;
  final String email;
  EditUser({required this.userName,required this.email});
}
class EditUserProfilePicture extends ProfileEvent {
  final dynamic profileImage;
  EditUserProfilePicture({required this.profileImage});
}
