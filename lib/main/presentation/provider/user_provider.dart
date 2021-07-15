import 'package:flutter/foundation.dart';
import 'package:prodia_test/login/domain/entities/user.dart';

class UserProvider with ChangeNotifier {
  User _user;

  UserProvider({@required User user}) {
    _user = user;
  }

  set profileImage(String value) {
    User tempUser = User(
        address: address,
        fullName: fullname,
        email: email,
        profileImage: value);
    _user = tempUser;
    notifyListeners();
  }

  User get user => _user;

  String get fullname {
    return _user?.fullName ?? '';
  }

  String get address {
    return _user?.address ?? '';
  }

  String get email {
    return _user?.email ?? '';
  }

  String get profileImage {
    return _user?.profileImage ?? '';
  }
}
