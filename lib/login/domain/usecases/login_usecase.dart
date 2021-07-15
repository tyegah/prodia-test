import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/data_state.dart';
import 'package:prodia_test/core/usecase.dart';
import 'package:prodia_test/login/domain/entities/user.dart';
import 'package:prodia_test/login/domain/repositories/login_repository.dart';

class LoginUseCase implements UseCase<DataState<User>, LoginRequestParams> {
  final LoginRepository _repository;

  LoginUseCase({@required LoginRepository repository})
      : assert(repository != null),
        _repository = repository;

  @override
  Future<DataState<User>> call({LoginRequestParams params}) async {
    return await _repository.login(params: params);
  }
}
