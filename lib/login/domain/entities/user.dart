import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String fullName;
  final String email;
  final String address;
  final String profileImage;

  const User({
    this.userId,
    this.fullName,
    this.email,
    this.address,
    this.profileImage,
  });

  @override
  List<Object> get props {
    return [
      userId,
      fullName,
      email,
      address,
      profileImage,
    ];
  }

  @override
  bool get stringify => true;
}
