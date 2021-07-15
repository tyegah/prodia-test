import 'package:equatable/equatable.dart';

class ProfileImage extends Equatable {
  final String profileImage;

  const ProfileImage({
    this.profileImage,
  });

  @override
  List<Object> get props {
    return [
      profileImage,
    ];
  }

  @override
  bool get stringify => true;
}
