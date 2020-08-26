import 'package:lkc/data/models/user_model.dart';
import 'package:lkc/data/repositories/auth_user.dart';

class LoginBloc {
  FireBaseAuthUser authUser = FireBaseAuthUser();

  Future<UserLKC> doLoginWithEmail(String email, String password) async {
    return await authUser.doLoginWithEmail(email, password);
  }
}
