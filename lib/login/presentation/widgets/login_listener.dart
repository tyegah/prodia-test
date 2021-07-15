import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prodia_test/login/presentation/blocs/login_bloc.dart';
import 'package:prodia_test/main/presentation/pages/main_page.dart';
import 'package:prodia_test/main/presentation/provider/user_provider.dart';
import 'package:provider/provider.dart';

class LoginListener<LoginState> extends StatefulWidget {
  final Stream<LoginState> stream;

  LoginListener({@required this.stream});

  @override
  _LoginListenerState createState() => _LoginListenerState<LoginState>();
}

class _LoginListenerState<LoginState> extends State<LoginListener<LoginState>> {
  StreamSubscription streamSubscription;

  @override
  void initState() {
    streamSubscription = widget.stream.listen(onNewValue);
    super.initState();
  }

  void onNewValue(LoginState state) {
    if (state is UserLoginDone) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(
              user: state.user,
            ),
            child: MainPage(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
