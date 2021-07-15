import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/bloc_with_state.dart';
import 'package:prodia_test/core/data_state.dart';
import 'package:prodia_test/core/image_helper.dart';
import 'package:prodia_test/main/domain/repositories/upload_image_repository.dart';
import 'package:prodia_test/main/domain/usecases/upload_image_usecase.dart';

part 'upload_state.dart';
part 'upload_event.dart';

class UploadImageBloc extends BlocWithState<UploadEvent, UploadState> {
  final UploadImageUseCase _useCase;
  final ImageHelper _imageHelper;

  UploadImageBloc(
      {@required UploadImageUseCase useCase, @required ImageHelper imageHelper})
      : assert(useCase != null && imageHelper != null),
        _useCase = useCase,
        _imageHelper = imageHelper,
        super(const ImageUploadInitial());

  @override
  Stream<UploadState> mapEventToState(UploadEvent event) async* {
    yield* _upload(event);
  }

  Stream<UploadState> _upload(UploadEvent event) async* {
    yield* runBlocProcess(() async* {
      if (event is UploadImage) {
        yield ImageUploading();
        final _imageFile = await _imageHelper
            .getFileNameAndBase64Image(event.path, imageQuality: 20);
        final dataState = await _useCase(
            params: UploadRequestParams(
                base64Image: _imageFile.image, imageType: "jpeg"));

        if (dataState is DataSuccess && dataState.data != null) {
          yield ImageUploaded(dataState.data.profileImage);
        }
        if (dataState is DataError) {
          yield ImageUploadError(dataState.error);
        }
      }
    });
  }
}
