part of 'upload_image_bloc.dart';

abstract class UploadState extends Equatable {
  final String profileImage;
  final Failure error;

  const UploadState({this.profileImage, this.error});

  @override
  List<Object> get props => [profileImage, error];
}

class ImageUploadInitial extends UploadState {
  const ImageUploadInitial();
}

class ImageUploading extends UploadState {
  const ImageUploading();
}

class ImageUploaded extends UploadState {
  const ImageUploaded(String profileImage) : super(profileImage: profileImage);
}

class ImageUploadError extends UploadState {
  const ImageUploadError(Failure error) : super(error: error);
}
