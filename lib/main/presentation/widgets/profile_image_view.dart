import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prodia_test/main/presentation/blocs/upload_image_bloc.dart';

class ProfileImageView extends StatelessWidget {
  final String photoUrl;

  ProfileImageView({Key key, @required this.photoUrl}) : super(key: key);

  Future<File> _getImage() async {
    final _picker = ImagePicker();
    final image = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 1,
    );
    final file = File(image.path);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    _uploadImage(String path) {
      BlocProvider.of<UploadImageBloc>(context).add(UploadImage(path: path));
    }

    _openCameraPage() async {
      try {
        final _picker = ImagePicker();
        final image = await _picker.getImage(
          source: ImageSource.camera,
          imageQuality: 1,
        );
        if (image != null) {
          _uploadImage(image.path);
        }
      } catch (e) {
        debugPrint("ERROR CAMERA $e");
      }
    }

    _onCameraTapped() async {
      if (Platform.isAndroid) {
        await _openCameraPage();
      } else {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            title: const Text('Choose Actions'),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: const Text('Open Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  final image = await _getImage();
                  if (image != null) {
                    _uploadImage(image.path);
                  }
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Open Camera'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _openCameraPage();
                },
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text('Cancel'),
              isDefaultAction: true,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      }
    }

    return Container(
      height: 100,
      width: 100,
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundImage: photoUrl != null && photoUrl.isNotEmpty
                ? NetworkImage(photoUrl)
                : AssetImage("assets/ic_profile.png"),
          ),
          Positioned(
            top: 0,
            right: 8,
            child: InkWell(
              onTap: _onCameraTapped,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.pinkAccent),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.linked_camera,
                    color: Colors.white,
                    size: 15.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
