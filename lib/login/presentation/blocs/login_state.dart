part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final User user;
  final Failure error;

  const LoginState({this.user, this.error});

  @override
  List<Object> get props => [user, error];
}

class UserLoginInitial extends LoginState {
  const UserLoginInitial();
}

class UserLoginLoading extends LoginState {
  const UserLoginLoading();
}

class UserLoginDone extends LoginState {
  const UserLoginDone(User user) : super(user: user);
}

class UserLoginError extends LoginState {
  const UserLoginError(Failure error) : super(error: error);
}

class UserValidated extends LoginState {
  final bool showError;
  final String usernameError;
  final String passwordError;

  UserValidated(this.showError, this.usernameError, this.passwordError);
}
