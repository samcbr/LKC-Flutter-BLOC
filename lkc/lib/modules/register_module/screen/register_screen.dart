import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lkc/modules/authenticator/bloc/auth_bloc.dart';

class RegisterScreen extends StatefulWidget {
  Function toggleView;
  RegisterScreen(this.toggleView);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthBloc authBloc = AuthBloc();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';
  bool validateEmail = false;
  bool validatePassword = false;
  bool validateConfirm = false;
  bool validateFirst = false;
  bool validateLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
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
                      onChanged: (val) {
                        setState(() {
                          validateEmail = true;
                          email = val;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email cannot be empty';
                        } else
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
                      onChanged: (val) {
                        setState(() {
                          validatePassword = true;
                          password = val;
                        });
                      },
                      autovalidate: validatePassword,
                      validator: (value) {
                        if (value.isEmpty) return 'Password cannot be empty';
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      autovalidate: validateConfirm,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          validateConfirm = true;
                          confirmPassword = val;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Confirm password cannot be empty';
                        else if (value != confirmPassword) {
                          return 'Confirm password and password do not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Confirm your password',
                        labelText: 'Confirm Password',
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      autovalidate: validateFirst,
                      onChanged: (val) {
                        setState(() {
                          validateFirst = true;
                          firstName = val;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Name cannot be empty';

                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your Name',
                        labelText: 'Name',
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    RaisedButton(
                      color: Colors.blue[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () async {
                        if (_formkey.currentState.validate())
                          await authBloc.registerNewUser(
                              email, password, firstName);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggleView();
                      },
                      child: Text(
                        'Already have an account ? Login',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
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
