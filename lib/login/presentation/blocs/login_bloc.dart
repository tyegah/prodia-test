import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:prodia_test/core/bloc_with_state.dart';
import 'package:prodia_test/core/data_state.dart';
import 'package:prodia_test/login/domain/entities/user.dart';
import 'package:prodia_test/login/domain/repositories/login_repository.dart';
import 'package:prodia_test/login/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BlocWithState<LoginEvent, LoginState> {
  final LoginUseCase _useCase;

  LoginBloc({@required LoginUseCase useCase})
      : assert(useCase != null),
        _useCase = useCase,
        super(const UserLoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield* _validate(event);
  }

  Stream<LoginState> _validate(LoginEvent event) async* {
    yield* runBlocProcess(() async* {
      if (event is UserValidation) {
        if (event.validate) {
          String usernameError = "";
          String passwordError = "";

          if (event.username == "") {
            usernameError = "*Field required";
          }

          if (event.password == "") {
            passwordError = "*Field required";
          }

          if (usernameError.isNotEmpty || passwordError.isNotEmpty) {
            yield UserValidated(true, usernameError, passwordError);
          } else {
            yield* _login(event.username, event.password);
          }
        } else {
          yield UserLoginInitial();
        }
      }
    });
  }

  Stream<LoginState> _login(String username, String password) async* {
    yield UserLoginLoading();
    final dataState = await _useCase(
        params: LoginRequestParams(username: username, password: password));

    if (dataState is DataSuccess && dataState.data != null) {
      debugPrint("BLOC DATA ${dataState.data}");
      yield UserLoginDone(dataState.data);
    }

    if (dataState is DataError) {
      yield UserLoginError(dataState.error);
    }
  }
}
