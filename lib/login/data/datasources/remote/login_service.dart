import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/base_http_client.dart';
import 'package:prodia_test/core/exceptions.dart';
import 'package:prodia_test/login/data/models/user_model.dart';
import 'package:prodia_test/shared/constants.dart';

abstract class LoginService {
  Future<UserModel> login({String username, String password});
}

class LoginServiceImpl implements LoginService {
  final BaseHttpClient _client;

  LoginServiceImpl({@required BaseHttpClient client})
      : assert(client != null),
        _client = client;
  @override
  Future<UserModel> login({String username, String password}) async {
    final response = await _client.post(
        url: kBaseUrl + "user/login",
        params: {"username": username, "password": password});
    if (response != null && response.statusCode == HTTP_STATUS_OK) {
      return UserResponseModel.fromJson(
              jsonDecode(utf8.decode(response.bodyBytes)))
          .data;
    } else {
      throw ServerException();
    }
  }
}
