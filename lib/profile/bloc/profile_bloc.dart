import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _profileRepo;

  ProfileBloc(this._profileRepo) : 
        super(const ProfileState()) {
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
      final profile = await _profileRepo.editProfile(Profile(username: event.userName, email: event.email,fileList: []));
      emit(ProfileLoaded(profile));
    
  }
  void _onEditUserProfilePicture(EditUserProfilePicture event, Emitter<ProfileState> emit) async {
      emit(const ProfileLoading());
      try {
        await _profileRepo.editProfilePicture(event.profileImage);
        final profile = await _profileRepo.getProfile();
        emit(ProfileLoaded(profile!));
      } catch (e) {
        emit(const ProfileError("Uploading profile pictue failed! Try Again (:"));
      }
  }
}
