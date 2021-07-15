import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/data_state.dart';
import 'package:prodia_test/login/domain/entities/user.dart';

class LoginRequestParams {
  final String username;
  final String password;

  const LoginRequestParams({@required this.username, @required this.password});
}

abstract class LoginRepository {
  Future<DataState<User>> login({LoginRequestParams params});
}
