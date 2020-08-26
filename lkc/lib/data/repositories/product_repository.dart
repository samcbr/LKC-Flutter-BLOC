import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lkc/data/models/product_model.dart';

abstract class ProductRepository //This class will be responsible for api call and providing result in the form of product model stream to the bloc
{
  Stream<List<TopProduct>> getTopProducts();
  Stream<List<ExtensionBoard>> getExtesionBoards(bool top);
  Stream<List<Mask>> getMasks(bool top);
  Stream<List<Sanitizer>> getSanitizers(bool top);
  Stream<List<ImmunoBooster>> getImmunoBoosters(bool top);
  Stream<List<Alarm>> getAlarms(bool top);
  Stream<List<Battery>> getBatteries(bool top);
  Stream<List<Led>> getLeds(bool top);
  Stream<List<MultiPlug>> getMultiPlugs(bool top);
  Stream<List<Cable>> getCables(bool top);
  Stream<List<DoorBell>> getDoorBells(bool top);
  Stream<List<Adapter>> getAdapters(bool top);
  Stream<List<Stand>> getStands(bool top);

  Stream<ExtensionBoard> getExtensionBoardById(int id);
  Stream<Mask> getMaskById(int id);
}

//Implements for getting data through firebase backend
class ProductRepositoryImpl implements ProductRepository {
  //Returns stream for all extension boards
  @override
  Stream<List<ExtensionBoard>> getExtesionBoards(bool top) {
    Stream<List<ExtensionBoard>> a = top
        ? Firestore.instance
            .collection('extensionBoards')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<ExtensionBoard>>(
              StreamTransformer<QuerySnapshot,
                  List<ExtensionBoard>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<ExtensionBoard> extensionBoards = snapshot.documents
                        .map(
                            (document) => ExtensionBoard.fromMap(document.data))
                        .toList();
                    // List<ExtensionBoard> extensionBoards = [];
                    // extensionBoards.add(ExtensionBoard.fromMap({
                    //   'id': 1,
                    //   'price': 2,
                    //   'brand': 'h',
                    //   'model': 'hh',
                    //   'wireLength': '4',
                    //   'image': 'jj'
                    // }));

                    sink.add(extensionBoards);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('extensionBoards')
            .snapshots()
            .transform<List<ExtensionBoard>>(
              StreamTransformer<QuerySnapshot,
                  List<ExtensionBoard>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<ExtensionBoard> extensionBoards = snapshot.documents
                        .map(
                            (document) => ExtensionBoard.fromMap(document.data))
                        .toList();
                    // List<ExtensionBoard> extensionBoards = [];
                    // extensionBoards.add(ExtensionBoard.fromMap({
                    //   'id': 1,
                    //   'price': 2,
                    //   'brand': 'h',
                    //   'model': 'hh',
                    //   'wireLength': '4',
                    //   'image': 'jj'
                    // }));

                    sink.add(extensionBoards);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<Adapter>> getAdapters(bool top) {
    Stream<List<Adapter>> a = top
        ? Firestore.instance
            .collection('adapters')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<Adapter>>(
              StreamTransformer<QuerySnapshot, List<Adapter>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Adapter> extensionBoards = snapshot.documents
                        .map((document) => Adapter.fromMap(document.data))
                        .toList();
                    sink.add(extensionBoards);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('adapters')
            .snapshots()
            .transform<List<Adapter>>(
              StreamTransformer<QuerySnapshot, List<Adapter>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Adapter> extensionBoards = snapshot.documents
                        .map((document) => Adapter.fromMap(document.data))
                        .toList();
                    sink.add(extensionBoards);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<Alarm>> getAlarms(bool top) {
    Stream<List<Alarm>> a = top
        ? Firestore.instance
            .collection('alarms')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<Alarm>>(
              StreamTransformer<QuerySnapshot, List<Alarm>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Alarm> extensionBoards = snapshot.documents
                        .map((document) => Alarm.fromMap(document.data))
                        .toList();
                    sink.add(extensionBoards);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('alarms')
            .snapshots()
            .transform<List<Alarm>>(
              StreamTransformer<QuerySnapshot, List<Alarm>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Alarm> alarms = snapshot.documents
                        .map((document) => Alarm.fromMap(document.data))
                        .toList();
                    sink.add(alarms);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<Battery>> getBatteries(bool top) {
    Stream<List<Battery>> a = top
        ? Firestore.instance
            .collection('batteries')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<Battery>>(
              StreamTransformer<QuerySnapshot, List<Battery>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Battery> batteries = snapshot.documents
                        .map((document) => Battery.fromMap(document.data))
                        .toList();
                    sink.add(batteries);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('batteries')
            .snapshots()
            .transform<List<Battery>>(
              StreamTransformer<QuerySnapshot, List<Battery>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Battery> batteries = snapshot.documents
                        .map((document) => Battery.fromMap(document.data))
                        .toList();
                    sink.add(batteries);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<Cable>> getCables(bool top) {
    Stream<List<Cable>> a = top
        ? Firestore.instance
            .collection('cables')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<Cable>>(
              StreamTransformer<QuerySnapshot, List<Cable>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Cable> cables = snapshot.documents
                        .map((document) => Cable.fromMap(document.data))
                        .toList();
                    sink.add(cables);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('cables')
            .snapshots()
            .transform<List<Cable>>(
              StreamTransformer<QuerySnapshot, List<Cable>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Cable> cables = snapshot.documents
                        .map((document) => Cable.fromMap(document.data))
                        .toList();
                    sink.add(cables);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<DoorBell>> getDoorBells(bool top) {
    Stream<List<DoorBell>> a = top
        ? Firestore.instance
            .collection('doorBells')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<DoorBell>>(
              StreamTransformer<QuerySnapshot, List<DoorBell>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<DoorBell> doorBells = snapshot.documents
                        .map((document) => DoorBell.fromMap(document.data))
                        .toList();
                    sink.add(doorBells);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('doorBells')
            .snapshots()
            .transform<List<DoorBell>>(
              StreamTransformer<QuerySnapshot, List<DoorBell>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<DoorBell> doorBells = snapshot.documents
                        .map((document) => DoorBell.fromMap(document.data))
                        .toList();
                    sink.add(doorBells);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<ImmunoBooster>> getImmunoBoosters(bool top) {
    Stream<List<ImmunoBooster>> a = top
        ? Firestore.instance
            .collection('immunoBoosters')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<ImmunoBooster>>(
              StreamTransformer<QuerySnapshot,
                  List<ImmunoBooster>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<ImmunoBooster> immunoBoosters = snapshot.documents
                        .map((document) => ImmunoBooster.fromMap(document.data))
                        .toList();
                    sink.add(immunoBoosters);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('immunoBoosters')
            .snapshots()
            .transform<List<ImmunoBooster>>(
              StreamTransformer<QuerySnapshot,
                  List<ImmunoBooster>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<ImmunoBooster> immunoBoosters = snapshot.documents
                        .map((document) => ImmunoBooster.fromMap(document.data))
                        .toList();
                    sink.add(immunoBoosters);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<Led>> getLeds(bool top) {
    Stream<List<Led>> a = top
        ? Firestore.instance
            .collection('leds')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<Led>>(
              StreamTransformer<QuerySnapshot, List<Led>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Led> leds = snapshot.documents
                        .map((document) => Led.fromMap(document.data))
                        .toList();
                    sink.add(leds);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('leds')
            .snapshots()
            .transform<List<Led>>(
              StreamTransformer<QuerySnapshot, List<Led>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Led> leds = snapshot.documents
                        .map((document) => Led.fromMap(document.data))
                        .toList();
                    sink.add(leds);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<Mask>> getMasks(bool top) {
    Stream<List<Mask>> a = top
        ? Firestore.instance
            .collection('masks')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<Mask>>(
              StreamTransformer<QuerySnapshot, List<Mask>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Mask> masks = snapshot.documents
                        .map((document) => Mask.fromMap(document.data))
                        .toList();
                    sink.add(masks);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('masks')
            .snapshots()
            .transform<List<Mask>>(
              StreamTransformer<QuerySnapshot, List<Mask>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Mask> masks = snapshot.documents
                        .map((document) => Mask.fromMap(document.data))
                        .toList();
                    sink.add(masks);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<MultiPlug>> getMultiPlugs(bool top) {
    Stream<List<MultiPlug>> a = top
        ? Firestore.instance
            .collection('multiPlugs')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<MultiPlug>>(
              StreamTransformer<QuerySnapshot, List<MultiPlug>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<MultiPlug> multiPlugs = snapshot.documents
                        .map((document) => MultiPlug.fromMap(document.data))
                        .toList();
                    sink.add(multiPlugs);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('multiPlugs')
            .snapshots()
            .transform<List<MultiPlug>>(
              StreamTransformer<QuerySnapshot, List<MultiPlug>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<MultiPlug> multiPlugs = snapshot.documents
                        .map((document) => MultiPlug.fromMap(document.data))
                        .toList();
                    sink.add(multiPlugs);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<Sanitizer>> getSanitizers(bool top) {
    Stream<List<Sanitizer>> a = top
        ? Firestore.instance
            .collection('sanitizers')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<Sanitizer>>(
              StreamTransformer<QuerySnapshot, List<Sanitizer>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Sanitizer> sanitizers = snapshot.documents
                        .map((document) => Sanitizer.fromMap(document.data))
                        .toList();
                    sink.add(sanitizers);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('sanitizers')
            .snapshots()
            .transform<List<Sanitizer>>(
              StreamTransformer<QuerySnapshot, List<Sanitizer>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Sanitizer> sanitizers = snapshot.documents
                        .map((document) => Sanitizer.fromMap(document.data))
                        .toList();
                    sink.add(sanitizers);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<Stand>> getStands(bool top) {
    Stream<List<Stand>> a = top
        ? Firestore.instance
            .collection('stands')
            .where('top', isEqualTo: true)
            .snapshots()
            .transform<List<Stand>>(
              StreamTransformer<QuerySnapshot, List<Stand>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Stand> stands = snapshot.documents
                        .map((document) => Stand.fromMap(document.data))
                        .toList();
                    sink.add(stands);
                  }
                },
              ),
            )
        : Firestore.instance
            .collection('stands')
            .snapshots()
            .transform<List<Stand>>(
              StreamTransformer<QuerySnapshot, List<Stand>>.fromHandlers(
                handleError: (e, _, sink) {
                  print("error");
                  sink.addError(e);
                },
                handleData: (snapshot, sink) {
                  if (snapshot.documents.isNotEmpty) {
                    List<Stand> stands = snapshot.documents
                        .map((document) => Stand.fromMap(document.data))
                        .toList();
                    sink.add(stands);
                  }
                },
              ),
            );
    return a;
  }

  @override
  Stream<List<TopProduct>> getTopProducts() {
    return Firestore.instance
        .collection('topProducts')
        .snapshots()
        .transform<List<TopProduct>>(
      StreamTransformer.fromHandlers(
        handleData: (snapshot, sink) {
          if (snapshot.documents.isNotEmpty) {
            List<TopProduct> topProducts = snapshot.documents
                .map(
                  (document) => TopProduct.fromMap(document.data),
                )
                .toList();
            sink.add(topProducts);
          }
        },
      ),
    );
  }

  @override
  Stream<ExtensionBoard> getExtensionBoardById(int id) {
    // TODO: implement getExtensionBoardById
    return Firestore.instance
        .collection('extensionBoards')
        .where('id', isEqualTo: id)
        .snapshots()
        .transform(
      StreamTransformer<QuerySnapshot, ExtensionBoard>.fromHandlers(
          handleData: (snapshot, sink) {
        if (snapshot.documents.isNotEmpty) {
          ExtensionBoard extensionBoard =
              ExtensionBoard.fromMap(snapshot.documents.first.data);
          sink.add(extensionBoard);
        }
      }),
    );
  }

  Stream<Mask> getMaskById(int id) {
    // TODO: implement getExtensionBoardById
    return Firestore.instance
        .collection('masks')
        .where('id', isEqualTo: id)
        .snapshots()
        .transform(
      StreamTransformer<QuerySnapshot, Mask>.fromHandlers(
        handleData: (snapshot, sink) {
          if (snapshot.documents.isNotEmpty) {
            Mask mask = Mask.fromMap(snapshot.documents.first.data);
            sink.add(mask);
          }
        },
      ),
    );
  }
}
