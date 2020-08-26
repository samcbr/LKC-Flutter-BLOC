import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
import 'package:lkc/data/models/product_model.dart';
import 'package:lkc/modules/authenticator/bloc/auth_bloc.dart';
import 'package:lkc/modules/cart_module/bloc/cart_bloc.dart';
import 'package:lkc/modules/order_module/screen/order_screen.dart';

class CartScreen extends StatefulWidget {
  final String user;
  CartScreen({this.user});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  AuthBloc authBloc;
  CartBloc cartBloc;
  dynamic cartStream;
  _CartScreenState() {
    authBloc = new AuthBloc();
    cartBloc = new CartBloc();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<List<Product>>(
        stream: cartBloc.getCart(widget.user),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: Colors.grey[200],
              child: snapshot.data.length > 0
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          flex: 9,
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  AutoSizeText(
                                                    '${snapshot.data[index].brand} ' +
                                                        snapshot
                                                            .data[index].model,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 2,
                                                    maxFontSize: 20,
                                                    minFontSize: 18,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text('Seller : LKC'),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Image.network(
                                                  snapshot.data[index].image),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '₹ ' +
                                                snapshot.data[index].price
                                                    .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                cartBloc.removeFromCart(
                                                  index,
                                                  widget.user,
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.delete,
                                                      color: Colors.grey[600],
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text('Remove'),
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey[400],
                                                      width: 1),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      '₹ 444',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return OrderScreen(
                                            snapshot.data,
                                            widget.user,
                                            fromBuyNow: false,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Center(
                                        child: AutoSizeText(
                                      'Proceed',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                          wordSpacing: 1.5),
                                      maxFontSize: 16,
                                    )),
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Text('No products added to cart'),
                    ),
            );
          } else {
            return Container(
              child: Card(
                child: PlaceholderLines(
                  count: 25,
                  animate: true,
                  color: Colors.blue[50],
                  align: TextAlign.center,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
