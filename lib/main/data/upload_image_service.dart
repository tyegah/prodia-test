import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/base_http_client.dart';
import 'package:prodia_test/core/exceptions.dart';
import 'package:prodia_test/main/data/upload_response_model.dart';
import 'package:prodia_test/shared/constants.dart';

abstract class UploadImageService {
  Future<ProfileImageModel> upload({String base64Image, String imageType});
}

class UploadImageServiceImpl implements UploadImageService {
  final BaseHttpClient _client;

  UploadImageServiceImpl({@required BaseHttpClient client})
      : assert(client != null),
        _client = client;

  @override
  Future<ProfileImageModel> upload(
      {String base64Image, String imageType}) async {
    final response = await _client.post(
        url: kBaseUrl + "user/upload",
        params: {"image_type": imageType, "image": base64Image});
    if (response != null && response.statusCode == HTTP_STATUS_OK) {
      return UploadResponseModel.fromJson(
              jsonDecode(utf8.decode(response.bodyBytes)))
          .data;
    } else {
      throw ServerException();
    }
  }
}
