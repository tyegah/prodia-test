part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ValidateForm extends LoginEvent {
  final bool validate;
  final String username;
  final String password;

  ValidateForm({this.validate, this.username, this.password});
}
