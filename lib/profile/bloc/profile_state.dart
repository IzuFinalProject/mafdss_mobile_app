part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.images,
  });

  final dynamic images;

  ProfileState copyWith({
    dynamic? images,
  }) {
    return ProfileState(
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [images];
}
