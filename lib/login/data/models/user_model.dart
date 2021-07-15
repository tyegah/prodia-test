import 'package:flutter/material.dart';
import 'package:prodia_test/login/domain/entities/user.dart';

class UserResponseModel {
  bool status;
  UserModel data;
  String message;

  UserResponseModel({this.status, this.data, this.message});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    debugPrint("JSON $json");
    if (json == null) return null;

    return UserResponseModel(
      status: json['status'] as bool,
      data: UserModel.fromJson(json['data']),
      message: json['message'] as String,
    );
  }
}

class UserModel extends User {
  const UserModel({
    int userId,
    String fullName,
    String email,
    String address,
    String profileImage,
  }) : super(
          userId: "\$userId",
          fullName: fullName,
          email: email,
          address: address,
          profileImage: profileImage,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    debugPrint("JSON $json");
    if (json == null) return null;

    return UserModel(
      userId: json['user_id'] as int,
      fullName: json['full_name'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      profileImage: json['profile_image'] as String,
    );
  }
}
