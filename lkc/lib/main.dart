import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lkc/modules/authenticator/screen/authenticator.dart';
import 'package:lkc/modules/login_module/screen/login_screen.dart';
import 'package:lkc/modules/main_module/screen/main_screen.dart';
import 'package:lkc/modules/product_list_module/screen/product_list_screen.dart';

import 'modules/product_detail_module/screen/detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth _auth = FirebaseAuth.instance;
  runApp(
    MaterialApp(
      //home: Authenticator(),
      home: Authenticator(),
    ),
  );
}

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('LKC'),
// //         ),
// //         body: StreamBuilder(
// //           stream: Firestore.instance.collection('productType').snapshots(),
// //           builder: (context, snapshot) {
// //             if (!snapshot.hasData) {
// //               return Center(
// //                 child: Text('Loading please wait...'),
// //               );
// //             } else {
// //               List<DocumentSnapshot> prodTypes = snapshot.data.documents;
// //               prodTypes.sort((item1, item2) =>
// //                   item1.data['type'].compareTo(item1.data['type']));
// //               return ListView.builder(
// //                   itemCount: snapshot.data.documents.length,
// //                   itemBuilder: (context, index) {
// //                     return Text('${prodTypes[index].data['type']}');
// //                   });
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// }
