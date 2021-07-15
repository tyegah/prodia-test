import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prodia_test/injector.dart';
import 'package:prodia_test/login/presentation/blocs/login_bloc.dart';
import 'package:prodia_test/login/presentation/widgets/login_listener.dart';
import 'package:prodia_test/shared/constants.dart';
import 'package:prodia_test/shared/themes.dart';
import 'package:prodia_test/shared/widgets/custom_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = injector<LoginBloc>();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocProvider(
        create: (_) => _loginBloc,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: Colors.white,
              ),
              SafeArea(
                child: Container(
                  color: Colors.white,
                ),
              ),
              SafeArea(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        // Header
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
                          width: double.infinity,
                          height: 100,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sign In",
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "",
                                    style: greyFontStyle,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: DEFAULT_MARGIN,
                          width: double.infinity,
                          color: bgColor,
                        ),
                        Column(
                          children: [
                            _buildTextFields(),
                            // CustomTextField(
                            //   controller: emailController,
                            //   text: "Username",
                            //   hintText: "Type your username",
                            //   errorText: "Wrong username",
                            // ),
                            // CustomTextField(
                            //   controller: passwordController,
                            //   text: "Password",
                            //   hintText: "Type your password",
                            //   secured: true,
                            // ),
                            _buildSignInButton(),
                            LoginListener(stream: _loginBloc.stream),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (_, state) {
      String usernameError = "";
      String passwordError = "";
      bool showError = false;
      if (state is UserValidated) {
        showError = state.showError;
        debugPrint("SHOW ERROR $showError");
        usernameError = state.usernameError;
        passwordError = state.passwordError;
      } else {
        showError = false;
        usernameError = "";
        passwordError = "";
      }

      return Column(
        children: [
          CustomTextField(
            onChange: () {
              if (showError) {
                debugPrint("VALIDATE REMOVE");
                _loginBloc.add(ValidateForm(validate: false));
              }
            },
            controller: emailController,
            text: "Username",
            hintText: "Type your username",
            errorText: usernameError,
          ),
          CustomTextField(
            onChange: () {
              if (showError) {
                _loginBloc.add(ValidateForm(validate: false));
              }
            },
            controller: passwordController,
            text: "Password",
            hintText: "Type your password",
            errorText: passwordError,
            secured: true,
          ),
        ],
      );
    });
  }

  Widget _buildSignInButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is UserLoginLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }

        return Container(
          height: 45,
          width: double.infinity,
          margin: EdgeInsets.only(top: 24),
          padding: EdgeInsets.symmetric(horizontal: DEFAULT_MARGIN),
          child: isLoading
              ? SpinKitFadingCircle(
                  color: mainColor,
                  size: 45,
                )
              : CustomButton(
                  color: mainColor,
                  textColor: Colors.black,
                  onPressed: () {
                    final username = emailController.text;
                    final password = passwordController.text;

                    _loginBloc.add(
                      ValidateForm(
                          validate: true,
                          username: username,
                          password: password),
                    );
                  },
                  title: "Sign In",
                ),
        );
      },
    );
  }

  Future<bool> _onWillPop() {
    return Future<bool>.value(false);
  }
}
