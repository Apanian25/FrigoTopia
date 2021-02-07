import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'recipe_row/recipe_row.dart';

class Scroller extends StatelessWidget {
  final List<Object> items;
  const Scroller({this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: this.items.length,
        itemBuilder: (BuildContext context, int index) {
          dynamic item = this.items[index];
          return Container(
            constraints: BoxConstraints.tightFor(height: 100),
            child:
                RecipeRow(item['url'], item['title'], item['img'], item['src']),
          );
        });
  }
}
