import 'package:lkc/data/models/product_model.dart';
import 'package:lkc/data/repositories/product_repository.dart';

class ProductListBloc {
  ProductRepositoryImpl productRepositoryImpl = ProductRepositoryImpl();

  Stream<List<ExtensionBoard>> extensionBoardStream(bool top) {
    return productRepositoryImpl.getExtesionBoards(top);
  }

  Stream<List<Mask>> maskStream(bool top) {
    return productRepositoryImpl.getMasks(top);
  }
}
