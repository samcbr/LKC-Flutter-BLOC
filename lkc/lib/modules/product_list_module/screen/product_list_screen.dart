import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lkc/data/models/product_model.dart';
import 'package:lkc/modules/product_detail_module/blocs/detail_bloc.dart';
import 'package:lkc/modules/product_detail_module/screen/detail_screen.dart';
import 'package:lkc/modules/product_list_module/bloc/product_list_bloc.dart';

class ProductList extends StatefulWidget {
  final Type type;
  final String uId;
  ProductList(this.type, {Key key, this.uId}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState(type);
}

class _ProductListState extends State<ProductList> {
  ProductListBloc productListBloc;
  Type type;
  _ProductListState(this.type);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productListBloc = ProductListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
        elevation: 0,
        actions: <Widget>[
          Icon(
            Icons.search,
            color: Colors.black,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: StreamBuilder(
          stream: type == ExtensionBoard
              ? productListBloc.extensionBoardStream(false)
              : productListBloc.maskStream(false),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        return ItemCard(snapshot.data[index], type, widget.uId);
                      },
                    ),
                  )
                : Text('Loading');
          }),
    );
  }
}

class ItemCard extends StatelessWidget {
  final item;
  final Type type;
  final String uId;
  const ItemCard(this.item, this.type, this.uId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(uId);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              item.id,
              type,
              uId,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Hexcolor(item.color),
                ),
                child: Image.network(
                  item.image,
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: AutoSizeText(
                  item.brand + ' ' + item.model,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                  maxLines: 2,
                  minFontSize: 9,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
              child: AutoSizeText(
                '₹' + item.price.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
