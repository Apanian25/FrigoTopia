import 'package:app/src/screens/recipes/recipeItem.dart';
import 'package:flutter/material.dart';

class Scroller extends StatelessWidget {
  List<Object> items;
  Function updateQty;
  Function delete;

  Scroller(items) {
    this.items = items;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.items.length,
        itemBuilder: (BuildContext context, int index) {
          dynamic item = this.items[index];
          return Container(
            constraints: BoxConstraints.tightFor(height: 150),
            child: RecipeItem(
                item['url'], item['title'], item['img'], item['src']),
          );
        });
  }
}
