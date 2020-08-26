import 'dart:async';

import 'package:lkc/data/models/product_model.dart';
import 'package:lkc/data/repositories/product_repository.dart';

class DetailBloc {
  ProductRepositoryImpl productRepositoryImpl = ProductRepositoryImpl();
  StreamController<int> controller = StreamController();
  Stream<int> quantityStream;
  int quantity = 0;

  DetailBloc() {
    quantityStream = controller.stream;
    controller.sink.add(quantity);
  }

  Stream<ExtensionBoard> extensionBoardStream(int id) {
    return productRepositoryImpl.getExtensionBoardById(id);
  }

  Stream<Mask> maskStream(int id) {
    return productRepositoryImpl.getMaskById(id);
  }

  void add() {
    quantity++;
    controller.sink.add(quantity);
  }

  void subtract() {
    if (quantity > 0) quantity--;
    controller.sink.add(quantity);
  }

  void dispose() {
    controller.close();
  }
}
