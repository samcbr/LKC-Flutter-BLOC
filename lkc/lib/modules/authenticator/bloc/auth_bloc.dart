import 'package:firebase_auth/firebase_auth.dart';
import 'package:lkc/data/models/user_model.dart';
import 'package:lkc/data/repositories/auth_user.dart';

class AuthBloc {
  FireBaseAuthUser user = new FireBaseAuthUser();
  Stream<UserLKC> getUserAuthStream() {
    return user.getUserStream();
  }

  void doLoginAnon() {
    user.doLoginAnon();
  }

  void doLogOutAnon() {
    user.doLogout();
  }

  Future<UserLKC> registerNewUser(
      String email, String password, String name) async {
    return await user.registerNewUser(
        email: email, password: password, name: name);
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await user.getCurrentUser();
  }
}
