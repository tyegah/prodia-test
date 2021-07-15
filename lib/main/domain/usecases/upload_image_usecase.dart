import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/data_state.dart';
import 'package:prodia_test/core/usecase.dart';
import 'package:prodia_test/main/domain/entity/profile_image.dart';
import 'package:prodia_test/main/domain/repositories/upload_image_repository.dart';

class UploadImageUseCase
    implements UseCase<DataState<ProfileImage>, UploadRequestParams> {
  final UploadImageRepository _repository;

  UploadImageUseCase({@required UploadImageRepository repository})
      : assert(repository != null),
        _repository = repository;

  @override
  Future<DataState<ProfileImage>> call({UploadRequestParams params}) async {
    return await _repository.upload(params: params);
  }
}
