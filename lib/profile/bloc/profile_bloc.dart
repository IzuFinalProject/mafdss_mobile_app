import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _profileRepo;

  ProfileBloc(this._profileRepo) : super(const ProfileInitial()) {
    on<GetUser>(_onGetUser);
    on<EditUser>(_onEditUser);
    on<EditUserProfilePicture>(_onEditUserProfilePicture);
    add(GetUser());
  }

  void _onGetUser(GetUser event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    await Future.delayed(const Duration(milliseconds: 1000));
    final profile = await _profileRepo.getProfile();
    emit(ProfileLoaded(profile!));
  }

  void _onEditUser(EditUser event, Emitter<ProfileState> emit) async {
    
      emit(const ProfileLoading());
      final profile = await _profileRepo.editProfile(Profile(username: event.userName, email: event.email));
      emit(ProfileLoaded(profile));
    
  }
  void _onEditUserProfilePicture(EditUserProfilePicture event, Emitter<ProfileState> emit) async {
      print("Uploading profile pictue");
      print(event.profileImage);
      emit(const ProfileLoading());
      await _profileRepo.editProfilePicture(event.profileImage);
  }
}
