class ServerException implements Exception {
  final String message;

  ServerException([this.message = ""]);

  @override
  String toString() {
    if (message != null && "" != message) {
      return message;
    }
    return super.toString();
  }
}

class TimeOutException implements Exception {
  final String message;

  TimeOutException([this.message = ""]);

  @override
  String toString() {
    if (message != null && "" != message) {
      return message;
    }
    return super.toString();
  }
}
