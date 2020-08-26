import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkc/data/models/product_model.dart';
import 'package:lkc/data/repositories/product_repository.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc {
  final _testSubject = BehaviorSubject<String>(); //streamcontroller
  ProductRepositoryImpl productRepositoryImpl = ProductRepositoryImpl();

  Stream<List<ExtensionBoard>> extensionBoardStream(bool top) {
    return productRepositoryImpl.getExtesionBoards(top);
  }

  Stream<List<TopProduct>> topProductStream() {
    return productRepositoryImpl.getTopProducts();
  }

  // Stream<int> func1() {
  //   //getter for stream
  //   return _testSubject.stream.transform(
  //       StreamTransformer<String, int>.fromHandlers(
  //           handleData: (snapshot, sink) {
  //     int a = snapshot.length;

  //     sink.add(a);
  //   }));
  // }

  void addData() async {
    _testSubject.add("loading"); //adding data to stream
    await Future.delayed(Duration(seconds: 5));
    _testSubject.add("loaded");
  }

  void dispose() {
    _testSubject?.close(); //close stream
  }
}
