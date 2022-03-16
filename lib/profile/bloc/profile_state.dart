part of 'profile_bloc.dart';

 class ProfileState {
  const ProfileState();
}
class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  const ProfileLoaded(this.profile);
   @override
  List<Object> get props => [profile];
}

class ProfileError extends ProfileState {
  final String error;
  const ProfileError(this.error);
}