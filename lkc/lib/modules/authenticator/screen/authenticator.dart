import 'package:flutter/material.dart';
import 'package:lkc/data/models/user_model.dart';
import 'package:lkc/modules/authenticator/bloc/auth_bloc.dart';
import 'package:lkc/modules/login_module/screen/login_screen.dart';
import 'package:lkc/modules/main_module/screen/main_screen.dart';
import 'package:lkc/modules/register_module/screen/register_screen.dart';

class Authenticator extends StatefulWidget {
  @override
  _AuthenticatorState createState() => _AuthenticatorState();
}

class _AuthenticatorState extends State<Authenticator> {
  final AuthBloc bloc = AuthBloc();
  bool toggle = false;
  toggleView() {
    setState(() {
      toggle = !toggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserLKC>(
      stream: bloc.getUserAuthStream(),
      builder: (context, snapshot) {
        return snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active
            ? MainScreen(
                uId: snapshot.data.uId,
              )
            : snapshot.connectionState == ConnectionState.waiting
                ? Scaffold()
                : toggle ? RegisterScreen(toggleView) : LoginScreen(toggleView);
      },
    );
  }
}
