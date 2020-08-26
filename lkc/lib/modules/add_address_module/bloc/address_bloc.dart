import 'package:lkc/data/repositories/auth_user.dart';
import 'package:lkc/data/repositories/product_repository.dart';

class AddressBloc {
  FireBaseAuthUser authUser = FireBaseAuthUser();
  Future<void> addDeliveryDetails(
      String address, String phone, String uId) async {
    try {
      return await authUser.addDeliveryDetails(address, phone, uId);
    } catch (e) {
      return null;
    }
  }
}
