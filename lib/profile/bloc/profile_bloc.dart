import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const ProfileState()) {
    on<ImageUpload>(_onImageUpload);
  }

  final UserRepository _userRepository;


  void _onImageUpload(
    ImageUpload event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(
      images: event.images
    ));
    
    _userRepository.uploadUserImage(state.images);
  }

}
