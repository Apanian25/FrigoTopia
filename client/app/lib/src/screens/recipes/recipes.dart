import 'dart:convert';
import 'package:app/src/screens/recipes/scroller.dart';
import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  List<dynamic> items;

  Recipe(items) {
    this.items = jsonDecode(items);
  }

  @override
  _Recipe createState() => new _Recipe(this.items);
}

class _Recipe extends State<Recipe> {
  List<dynamic> _items;
  _Recipe(items) {
    _items = items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Validate Options'),
        ),
        body: Container(
          child: Flexible(child: Container(child: Scroller(_items)), flex: 10),
        ),
      ),
    );
  }
}
