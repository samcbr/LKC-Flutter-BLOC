import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lkc/data/models/product_model.dart';
import 'package:lkc/modules/cart_module/bloc/cart_bloc.dart';
import 'package:lkc/modules/order_module/screen/order_screen.dart';
import 'package:lkc/modules/product_detail_module/blocs/detail_bloc.dart';

class DetailScreen extends StatefulWidget {
  int prodId;
  Type prodType;
  String uId;
  DetailScreen(int prodId, Type prodType, String uId) {
    this.prodId = prodId;
    this.prodType = prodType;
    this.uId = uId;
  }
  @override
  _DetailScreenState createState() => _DetailScreenState(prodId, prodType);
}

class _DetailScreenState extends State<DetailScreen> {
  int prodId;
  Type prodType;
  DetailBloc detailBloc = DetailBloc();
  CartBloc cartBloc;
  _DetailScreenState(int prodId, Type prodType) {
    this.prodId = prodId;
    this.prodType = prodType;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    detailBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailBloc = DetailBloc();
    cartBloc = CartBloc();
    //_mainBloc.addData();
  }

  @override
  Widget build(BuildContext context) {
    if (prodType == ExtensionBoard) {
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
        ),
        body: Container(
          child: StreamBuilder<ExtensionBoard>(
            stream: detailBloc.extensionBoardStream(prodId),
            builder: (context, snapshot) {
              print(snapshot.data);
              return snapshot.hasData
                  ? Container(
                      color: Hexcolor(snapshot.data.color),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              color: Hexcolor(snapshot.data.color),
                              child: CarouselSlider.builder(
                                itemCount: 1,
                                itemBuilder: (context, index) => Card(
                                  color: Hexcolor(snapshot.data.color),
                                  elevation: 0,
                                  child: Container(
                                    child: Image.network(
                                      snapshot.data.image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                options: CarouselOptions(
                                  aspectRatio: 13 / 9,
                                  viewportFraction: 0.8,
                                  initialPage: 0,
                                  enableInfiniteScroll: false,
                                  reverse: false,
                                  autoPlay: false,
                                  autoPlayInterval: Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ),
                            flex: 5,
                          ),
                          Expanded(
                            flex: 5,
                            child: Card(
                              margin: EdgeInsets.all(0),
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    topRight: Radius.circular(40)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.brand +
                                          ' ' +
                                          snapshot.data.model,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Available !!!',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '₹' + snapshot.data.price.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Card(
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '4.0',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      cartBloc.addToCart(
                                          snapshot.data, widget.uId);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Center(
                                          child: Text(
                                        'ADD TO CART',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      List<Product> order = [];
                                      //print(snapshot);
                                      order.add(snapshot.data);
                                      cartBloc.addToCart(
                                          snapshot.data, widget.uId);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderScreen(order, widget.uId),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      color: Colors.redAccent,
                                      child: Center(
                                        child: Text(
                                          'BUY NOW',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : PlaceholderLines(
                      count: 10,
                      align: TextAlign.center,
                      animate: true,
                    );
            },
          ),
        ),
      );
    } else if (prodType == Mask) {
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
        ),
        body: Container(
          child: StreamBuilder<Mask>(
              stream: detailBloc.maskStream(prodId),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Container(
                        color: Hexcolor(snapshot.data.color),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                color: Hexcolor(snapshot.data.color),
                                child: CarouselSlider.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) => Card(
                                    color: Hexcolor(snapshot.data.color),
                                    elevation: 0,
                                    child: Container(
                                      child: Image.network(
                                        snapshot.data.image,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  options: CarouselOptions(
                                    aspectRatio: 13 / 9,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    reverse: false,
                                    autoPlay: false,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ),
                              flex: 5,
                            ),
                            Expanded(
                              flex: 5,
                              child: Card(
                                margin: EdgeInsets.all(0),
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.brand +
                                            ' ' +
                                            snapshot.data.model,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Available !!!',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '₹' +
                                                snapshot.data.price.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Card(
                                            color: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '4.0',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        cartBloc.addToCart(
                                            snapshot.data, widget.uId);
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        child: Center(
                                            child: Text(
                                          'ADD TO CART',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        List<Product> order = [];
                                        order.add(snapshot.data);
                                        cartBloc.addToCart(
                                            snapshot.data, widget.uId);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderScreen(order, widget.uId),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        color: Colors.redAccent,
                                        child: Center(
                                          child: Text(
                                            'BUY NOW',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : PlaceholderLines(
                        count: 10,
                        align: TextAlign.center,
                        animate: true,
                      );
              }),
        ),
      );
    } else {
      return Text('Not defined');
    }
  }
}
