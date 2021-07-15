import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/data_state.dart';
import 'package:prodia_test/main/domain/entity/profile_image.dart';

class UploadRequestParams {
  final String base64Image;
  final String imageType;

  const UploadRequestParams(
      {@required this.base64Image, @required this.imageType});
}

abstract class UploadImageRepository {
  Future<DataState<ProfileImage>> upload({UploadRequestParams params});
}
