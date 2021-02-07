import 'package:app/src/screens/recipes/scroller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  String itemName;

  Recipe(itemName) {
    this.itemName = itemName;
  }

  @override
  _Recipe createState() => new _Recipe(this.itemName);
}

class _Recipe extends State<Recipe> {
  List<dynamic> _items;
  String _itemName;

  _Recipe(itemName) {
    _itemName = itemName;
    _items = [];
  }

  @override
  void initState() {
    super.initState();
    String endpoint = "http://23.233.161.96/api/v1/recipe?item=" + _itemName;
    Dio dio = new Dio();
    dio.get(endpoint).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          _items = response.data;
        });
      } else {
        print("BAD");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(child: Scroller(items: _items), flex: 1),
    );
  }
}
