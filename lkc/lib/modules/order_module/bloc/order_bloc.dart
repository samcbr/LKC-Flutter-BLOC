import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkc/data/models/product_model.dart';

class OrderBloc {
  placeOrder(
      List<Product> items, String uId, String address, String mobile) async {
    DocumentSnapshot user =
        await Firestore.instance.collection('users').document(uId).get();

    List<Map<String, dynamic>> orders = items.map(
      (item) {
        Map<String, dynamic> order;
        order['brand'] = item.brand;
        order['id'] = item.id;
        order['image'] = item.id;
        order['model'] = item.model;
        order['price'] = item.price;
        return order;
      },
    );
    Map<String, dynamic> order = {
      'address': address,
      'mobile': mobile,
      'uId': uId,
      'orders': orders,
      'name': user.data['name'],
      'email': user.data['email']
    };
    await Firestore.instance.collection('orders').add(order);
  }

  Stream<String> getAddress(String uId) {
    print(uId);
    return Firestore.instance
        .collection('users')
        .document(uId)
        .snapshots()
        .transform(StreamTransformer<DocumentSnapshot, String>.fromHandlers(
      handleData: (data, sink) {
        String address = data.data['address'];
        print(address);
        sink.add(data.data['address']);
      },
    ));
  }
}
