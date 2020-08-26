//This class is responsible for authenticating the user
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lkc/data/models/user_model.dart';

abstract class AuthUser {
  void doLoginAnon();
  void doLogout();
  void registerNewUser({String email, String password});
  void doLoginWithEmail(String email, String password);
}

class FireBaseAuthUser extends AuthUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getUserStream() {
    return _auth.onAuthStateChanged.map((event) => UserLKC(event.uid));
  }

  @override
  void doLoginAnon() async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {}
  }

  @override
  void doLogout() async {
    // TODO: implement doLogout
    try {
      await _auth.signOut();
    } catch (e) {}
  }

  @override
  Future<UserLKC> registerNewUser(
      {String email, String password, String name}) async {
    // TODO: implement registerNewUser
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Firestore.instance
          .collection('users')
          .document(result.user.uid)
          .setData({"email": email, "name": name, "cart": [], "address": ""});

      //print(result);
      return UserLKC(result.user.uid);
    } catch (e) {
      return null;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _auth.currentUser();
  }

  @override
  Future<UserLKC> doLoginWithEmail(String email, String password) async {
    // TODO: implement doLoginWithEmail
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print('Logged in');
    return UserLKC(result.user.uid);
  }

  Future<void> addDeliveryDetails(
      String address, String phone, String uId) async {
    try {
      await Firestore.instance.collection('users').document(uId).setData(
        {'address': address, 'mobile': phone},
        merge: true,
      );
    } catch (e) {
      return null;
    }
  }
}
