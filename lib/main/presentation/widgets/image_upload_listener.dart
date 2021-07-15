import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prodia_test/main/presentation/blocs/upload_image_bloc.dart';
import 'package:prodia_test/main/presentation/pages/main_page.dart';
import 'package:prodia_test/main/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ImageUploadListener<UploadState> extends StatefulWidget {
  final Stream<UploadState> stream;

  ImageUploadListener({@required this.stream});

  @override
  _ImageUploadListenerState createState() =>
      _ImageUploadListenerState<UploadState>();
}

class _ImageUploadListenerState<UploadState>
    extends State<ImageUploadListener<UploadState>> {
  StreamSubscription streamSubscription;
  bool _isLoading = false;

  @override
  void initState() {
    streamSubscription = widget.stream.listen(onNewValue);
    super.initState();
  }

  void onNewValue(UploadState state) {
    if (state is ImageUploading) {
      _isLoading = true;
    } else {
      _isLoading = false;
    }

    if (state is ImageUploadError) {
      debugPrint("IMAGE UPLOAD ERROR ${state.error}");
    }

    if (state is ImageUploaded) {
      imageCache.clear();
      imageCache.clearLiveImages();
      final provider = Provider.of<UserProvider>(context, listen: false);
      provider.profileImage = state.profileImage;
    }
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? LoadingIndicator() : SizedBox();
  }
}
