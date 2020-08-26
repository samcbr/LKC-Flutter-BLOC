import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lkc/data/models/product_model.dart';
import 'package:lkc/modules/add_address_module/screen/add_address.dart';
import 'package:lkc/modules/cart_module/bloc/cart_bloc.dart';
import 'package:lkc/modules/order_module/bloc/order_bloc.dart';

class OrderScreen extends StatefulWidget {
  List<Product> order;
  String uId;
  bool fromBuyNow = true;
  OrderScreen(this.order, this.uId, {this.fromBuyNow});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderBloc orderBloc = OrderBloc();
  CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Order Summary',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<String>(
          stream: orderBloc.getAddress(widget.uId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Card(
                                child: snapshot.data.length == 0
                                    ? Container(
                                        height: 300,
                                        padding: EdgeInsets.all(8),
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text('No address added'),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return AddAddress(
                                                          widget.uId);
                                                    },
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.elliptical(8, 8),
                                                  ),
                                                ),
                                                //color: Colors.redAccent,
                                                padding: EdgeInsets.all(16),
                                                child: Text(
                                                  'Add Address',
                                                  style: TextStyle(
                                                    letterSpacing: 1.25,
                                                    wordSpacing: 1.25,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.all(8),
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            SizedBox(height: 16),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: AutoSizeText(
                                                    'Delivery Address :',
                                                    style: TextStyle(
                                                        letterSpacing: 1.25,
                                                        wordSpacing: 1.25,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: AutoSizeText(
                                                      snapshot.data,
                                                      style: TextStyle(
                                                          fontSize: 40),
                                                      maxLines: 3,
                                                      maxFontSize: 16,
                                                      minFontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            RaisedButton(
                                              color: Colors.redAccent,
                                              child: Text(
                                                'Edit Details',
                                                style: TextStyle(
                                                  letterSpacing: 1.25,
                                                  wordSpacing: 1.25,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return AddAddress(
                                                          widget.uId);
                                                    },
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              StreamBuilder<List<Product>>(
                                  stream: cartBloc.getCart(widget.uId),
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: Container(
                                                  padding: EdgeInsets.all(8),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 3,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                AutoSizeText(
                                                                  snapshot
                                                                          .data[
                                                                              index]
                                                                          .brand +
                                                                      ' ' +
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .model,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  maxLines: 2,
                                                                  maxFontSize:
                                                                      20,
                                                                  minFontSize:
                                                                      18,
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Text(
                                                                    'Seller : LKC'),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Image.network(
                                                                snapshot
                                                                    .data[index]
                                                                    .image),
                                                            flex: 1,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          '₹ ' +
                                                              snapshot
                                                                  .data[index]
                                                                  .price
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartBloc
                                                                  .removeFromCart(
                                                                      index,
                                                                      widget
                                                                          .uId);
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                            .grey[
                                                                        600],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Text(
                                                                      'Remove'),
                                                                ],
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
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
                                            },
                                          )
                                        : Container(
                                            child: Card(
                                              child: PlaceholderLines(
                                                count: 25,
                                                animate: true,
                                                color: Colors.blue[50],
                                                align: TextAlign.center,
                                              ),
                                            ),
                                          );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(
                                child: AutoSizeText(
                                  '₹ 797',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  maxFontSize: 24,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                if (snapshot.data.isNotEmpty) {
                                  Navigator.pop(context);
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Please add address to place order",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.grey,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'Place Order',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.25,
                                        wordSpacing: 1.5),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: snapshot.data.isNotEmpty
                                      ? Colors.redAccent
                                      : Colors.grey[700],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 17,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
          }),
    );
  }
}
