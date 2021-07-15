import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/exceptions.dart';
import 'package:prodia_test/login/data/datasources/remote/login_service.dart';
import 'package:prodia_test/login/domain/entities/user.dart';
import 'package:prodia_test/core/data_state.dart';
import 'package:prodia_test/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService _remoteDataSource;

  LoginRepositoryImpl({@required LoginService remoteDataSource})
      : assert(remoteDataSource != null),
        _remoteDataSource = remoteDataSource;

  @override
  Future<DataState<User>> login({@required LoginRequestParams params}) async {
    try {
      final result = await _remoteDataSource.login(
          username: params.username, password: params.password);
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
