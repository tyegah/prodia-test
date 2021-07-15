import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure([this.message = ""]);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    if (message != null && "" != message) {
      return message;
    }
    return super.toString();
  }
}

abstract class DataState<T> {
  final T data;
  final Failure error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(Failure error) : super(error: error);
}
