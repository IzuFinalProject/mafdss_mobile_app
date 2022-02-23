part of 'profile_bloc.dart';



abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ImageUpload extends ProfileEvent {
  const ImageUpload(this.images);

  final dynamic images;

  @override
  List<Object> get props => [images];
}

