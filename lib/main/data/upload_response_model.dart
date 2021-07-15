import 'package:prodia_test/main/domain/entity/profile_image.dart';

class UploadResponseModel {
  bool status;
  ProfileImageModel data;
  String message;

  UploadResponseModel({this.status, this.data, this.message});

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return UploadResponseModel(
      status: json['status'] as bool,
      data: ProfileImageModel.fromJson(json['data']),
      message: json['message'] as String,
    );
  }
}

class ProfileImageModel extends ProfileImage {
  const ProfileImageModel({
    String profileImage,
  }) : super(
          profileImage: profileImage,
        );

  factory ProfileImageModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return ProfileImageModel(
      profileImage: json['profile_image'] as String,
    );
  }
}
