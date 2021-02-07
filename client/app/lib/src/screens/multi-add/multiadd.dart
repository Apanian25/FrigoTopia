import 'dart:convert';

import 'package:app/src/screens/fridge/food_item_image.dart';
import 'package:app/src/screens/fridge/item.dart';
import 'package:app/src/screens/multi-add/infiniteScroll.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiAdd extends StatefulWidget {
  List<dynamic> items;
  Function addItemMain;

  MultiAdd(Map map) {
    print(map['data']);
    this.items = jsonDecode(map['data']);
    this.addItemMain = map['addItem'];
  }

  @override
  _MultiAdd createState() => new _MultiAdd(this.items);
}

class _MultiAdd extends State<MultiAdd> {
  List<dynamic> _items;
  _MultiAdd(items) {
    _items = items;
  }

  Future updateQty(name, exp, value, tip) async {
    if (value > 0) {
      setState(() {
        _items[_items.indexWhere((element) => element['name'] == name)] = {
          "name": name,
          "expiryDate": exp,
          "qty": value.toString(),
          "tip": tip
        };
      });
    }
  }

  Future delete(name) async {
    setState(() {
      _items.removeAt(_items.indexWhere((element) => element['name'] == name));
    });
  }

  Future addItems() async {
    Dio dio = new Dio();

    for (var item in _items) {
      // dio
      //     .put('http://23.233.161.96/api/v1/modify/items', data: item)
      //     .then((res) {
      String name = item['name'].toLowerCase();
      print("Days left: ${item['daysLeft']}");
      widget.addItemMain(
          data: ItemData(
        daysLeft: item['daysLeft'],
        expiryDate: item['expiryDate'],
        imagePath: foodDict[name],
        itemId: item['itemId'],
        quantity: int.parse(item['qty']),
        name: name,
      ));
      // });
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Validate Items'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: Container(
                      child: InfiniteScroll(_items, updateQty, delete)),
                  flex: 10),
              Flexible(
                  flex: 2,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(225, 240, 225, 1),
                          // border: Border.all(
                          //   color: Colors.black87,
                          // ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(
                                        right: 0,
                                        left: 0,
                                        top: 10.0,
                                        bottom: 0),
                                    child: Text(
                                      "Totel Items: " +
                                          _items.fold(
                                              '0',
                                              (sum, item) => (int.parse(sum) +
                                                      int.parse(item['qty']))
                                                  .toString()),
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .5),
                                      ),
                                    ))
                              ]),
                          Container(
                              width: 400,
                              padding: const EdgeInsets.only(
                                  right: 30.0,
                                  left: 30.0,
                                  top: 20.0,
                                  bottom: 5.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Color(0000000))),
                                onPressed: () {
                                  addItems();
                                },
                                color: Color(0xffa6e4a6),
                                textColor: Color(0xff396339),
                                child: Text("Add Item",
                                    style: TextStyle(fontSize: 14)),
                              )),
                        ],
                      ))),
            ]),
      ),
    );
  }
}
