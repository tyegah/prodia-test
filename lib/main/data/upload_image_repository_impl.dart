import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/exceptions.dart';
import 'package:prodia_test/core/data_state.dart';
import 'package:prodia_test/main/data/upload_image_service.dart';
import 'package:prodia_test/main/domain/entity/profile_image.dart';
import 'package:prodia_test/main/domain/repositories/upload_image_repository.dart';

class UploadImageRepositoryImpl implements UploadImageRepository {
  final UploadImageService _service;

  UploadImageRepositoryImpl({@required UploadImageService service})
      : assert(service != null),
        _service = service;

  @override
  Future<DataState<ProfileImage>> upload({UploadRequestParams params}) async {
    try {
      final result = await _service.upload(
        base64Image: params.base64Image,
        imageType: params.imageType,
      );
      debugPrint("RESULT $result");
      return DataSuccess(result);
    } catch (e) {
      if (e is ServerException) {
        return DataError(ServerFailure(e.message));
      }
      return DataError(ServerFailure());
    }
  }
}
