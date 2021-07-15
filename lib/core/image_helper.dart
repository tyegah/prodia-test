import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

abstract class ImageHelper {
  Future<ImageData> getFileNameAndBase64Image(String originalPath,
      {int imageQuality = 20});
}

class ImageData {
  final String name;
  final String image;

  ImageData({@required this.name, @required this.image});
}

class ImageHelperImpl implements ImageHelper {
  @override
  Future<ImageData> getFileNameAndBase64Image(String originalPath,
      {int imageQuality = 20}) async {
    try {
      final uuid = Uuid().v1();
      final destinationPath = await getApplicationDocumentsDirectory();
      File resultFile;
      String fileName;

      if (_shouldCompressImage(originalPath)) {
        try {
          final result = await FlutterImageCompress.compressAndGetFile(
            originalPath,
            "${destinationPath.path}/$uuid.jpeg",
            quality: imageQuality,
          );
          resultFile = result;
          fileName = result.path.split("/").last;
        } catch (error) {
          debugPrint(error);
        }
      } else {
        fileName = originalPath.split("/").last;
        File file = File(originalPath);
        String newPath = "${destinationPath.path}/$uuid.jpeg";
        if (originalPath != newPath) {
          resultFile = await file.copy(newPath);
        } else {
          resultFile = file;
        }
      }

      return ImageData(
        name: fileName,
        image: base64Encode(resultFile.readAsBytesSync()),
      );
    } catch (e) {
      debugPrint("ERROR BASE64 $e");
      return null;
    }
  }

  bool _shouldCompressImage(String path) {
    final resultFile = File(path);
    final fileSize = resultFile.lengthSync() / (1024 * 1024);
    // IF SIZE IS < 200KB, DON'T COMPRESS
    if (fileSize < 0.2) {
      return false;
    }
    return true;
  }
}
