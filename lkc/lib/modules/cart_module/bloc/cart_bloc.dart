import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lkc/data/models/product_model.dart';
import 'package:lkc/data/repositories/auth_user.dart';

class CartBloc {
  FirebaseAuth auth;

  CartBloc() {
    auth = FirebaseAuth.instance;
  }
  Stream<List<Mask>> getCart(String uid) {
    Stream<List<Mask>> snapshot = Firestore.instance
        .collection('users')
        .document(uid)
        .snapshots()
        .transform(
      StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          //print(data.data['cart']);
          dynamic l = data.data['cart'];

          List<Mask> cart = List<Mask>.from(l.map((item) {
            //vvi When you receive a list from firebase dart considers it as immutable therefore it has to be passed in .from constructor to make it mutable
            Mask prod = Mask(
              id: item['id'],
              brand: item['brand'],
              price: item['price'],
              model: item['model'],
              image: item['image'],
            );

            return prod;
          }).toList());

          sink.add(cart);
        },
      ),
    );
    return snapshot;
  }

  addToCart(Product item, String uid) async {
    DocumentSnapshot doc =
        await Firestore.instance.collection('users').document(uid).get();
    List<dynamic> cart = new List.from(doc.data['cart']);
    Map<String, dynamic> itemMap = {
      'brand': item.brand,
      'id': item.id,
      'image': item.image,
      'model': item.model,
      'price': item.price,
    };
    cart.add(itemMap);
    await Firestore.instance
        .collection('users')
        .document(uid)
        .setData({'cart': cart}, merge: true);
  }

  removeFromCart(int index, String uId) async {
    DocumentSnapshot doc =
        await Firestore.instance.collection('users').document(uId).get();
    List<dynamic> cart = new List.from(doc.data['cart']);
    cart.removeAt(index);
    await Firestore.instance
        .collection('users')
        .document(uId)
        .setData({'cart': cart}, merge: true);
  }
}
