part of 'upload_image_bloc.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends UploadEvent {
  final String path;

  UploadImage({this.path});
}
