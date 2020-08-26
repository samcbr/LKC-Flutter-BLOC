import 'package:flutter/material.dart';
import 'package:lkc/data/models/user_model.dart';
import 'package:lkc/modules/authenticator/bloc/auth_bloc.dart';
import 'package:lkc/modules/login_module/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  Function toggleView;
  LoginScreen(this.toggleView);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc loginBloc = LoginBloc();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool validateEmail = false;
  bool validatePassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: 200,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autovalidate: validateEmail,
                      onChanged: (value) {
                        validateEmail = true;
                        email = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Email cannot be empty';
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      obscureText: true,
                      autovalidate: validatePassword,
                      decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value.isEmpty) return 'Password cannot be empty';
                        return null;
                      },
                      onChanged: (value) {
                        validatePassword = true;
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    RaisedButton(
                      color: Colors.blue[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () async {
                        if (_formKey.currentState.validate())
                          await loginBloc.doLoginWithEmail(email, password);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Text(
                        "Don't have an account ? Register",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
