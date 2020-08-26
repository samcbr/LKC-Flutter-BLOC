import 'dart:wasm';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:lkc/data/models/product_model.dart';
import 'package:lkc/modules/authenticator/bloc/auth_bloc.dart';
import 'package:lkc/modules/cart_module/screen/cart_screen.dart';
import 'package:lkc/modules/main_module/blocs/main_bloc.dart';
import 'package:lkc/modules/product_detail_module/screen/detail_screen.dart';
import 'package:lkc/modules/product_list_module/screen/product_list_screen.dart';

class MainScreen extends StatefulWidget {
  final String uId;
  const MainScreen({Key key, this.uId}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _mainBloc = MainBloc();
  final _authBloc = AuthBloc();

  Widget menuItem(String icon, String title, Type type) {
    //function for creating menu item
    return GestureDetector(
      onTap: () {
        print(type.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductList(
              type,
              uId: widget.uId,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/icons/' + icon,
              height: 40,
              width: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget topItem(item, Type type, String uId) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(item.id, type, uId),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
        borderOnForeground: true,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network(
                item.image,
                height: 100,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '${item.brand} ${item.model}',
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '₹ ${item.price}',
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mainBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_mainBloc.addData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CartScreen(
                    user: widget.uId,
                  );
                }));
              },
            ),
            IconButton(
                icon: Icon(
                  Icons.power_settings_new,
                  color: Colors.black,
                ),
                onPressed: () {
                  _authBloc.doLogOutAnon();
                })
          ],
        ),
        backgroundColor: Colors.blueGrey[50],
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: StreamBuilder<List<ExtensionBoard>>(
            stream: _mainBloc.extensionBoardStream(false),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Column(
                            children: <Widget>[
                              StreamBuilder<List<TopProduct>>(
                                stream: _mainBloc.topProductStream(),
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? CarouselSlider.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) => Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            color: Color(
                                              int.parse(
                                                  snapshot.data[index].color),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              child: Image.network(
                                                snapshot.data[index].image,
                                              ),
                                            ),
                                          ),
                                          options: CarouselOptions(
                                            height: 150,
                                            aspectRatio: 16 / 9,
                                            viewportFraction: 0.8,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 3),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        )
                                      : Card(
                                          child: Container(
                                            height: 150,
                                            width: double.infinity,
                                            child: Center(
                                              child: PlaceholderLines(
                                                count: 3,
                                                align: TextAlign.center,
                                                animate: true,
                                                color: Colors.blue[50],
                                              ),
                                            ),
                                          ),
                                        );
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Our Products',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 3,
                                childAspectRatio: 3 / 2,
                                shrinkWrap: true,
                                children: <Widget>[
                                  menuItem('mask.png', 'Masks', Mask),
                                  menuItem(
                                      'sanitizer.png', 'Sanitizers', Sanitizer),
                                  menuItem('immune.jpg', 'ImmunoBoosters',
                                      ImmunoBooster),
                                  menuItem('alarm.png', 'Alarms', Alarm),
                                  menuItem('extensionboard.png',
                                      'Extension Boards', ExtensionBoard),
                                  menuItem('ledfan.png', 'Batteries', Battery),
                                  menuItem('led.png', 'LED Lights', Led),
                                  menuItem('multiplug.png', 'Multi Plugs',
                                      MultiPlug),
                                  menuItem('cable.png', 'Cables', Cable),
                                  menuItem(
                                      'doorbell.png', 'Door Bells', DoorBell),
                                  menuItem('adapter.png', 'Adapters', Adapter),
                                  menuItem('stand.png', 'Stands', Stand),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Top Extension Boards',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              StreamBuilder<List<ExtensionBoard>>(
                                stream: _mainBloc.extensionBoardStream(true),
                                builder: (context, snapshot) {
                                  return snapshot.hasData
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GridView.count(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            crossAxisCount: 2,
                                            shrinkWrap: true,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8,
                                            children: <Widget>[
                                              topItem(snapshot.data[0],
                                                  ExtensionBoard, widget.uId),
                                              topItem(snapshot.data[1],
                                                  ExtensionBoard, widget.uId),
                                              topItem(snapshot.data[2],
                                                  ExtensionBoard, widget.uId),
                                              topItem(snapshot.data[3],
                                                  ExtensionBoard, widget.uId),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          width: double.infinity,
                                          height: 300,
                                          padding: EdgeInsets.all(16),
                                          child: Center(
                                            child: Card(
                                              child: PlaceholderLines(
                                                count: 4,
                                                align: TextAlign.center,
                                                animate: true,
                                                color: Colors.blue[50],
                                              ),
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: Card(
                        child: PlaceholderLines(
                          count: 50,
                          animate: true,
                          color: Colors.blue[50],
                          align: TextAlign.center,
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
