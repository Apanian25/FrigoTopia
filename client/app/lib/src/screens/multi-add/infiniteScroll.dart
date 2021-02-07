import 'package:app/src/app.dart';
import 'package:flutter/material.dart';

import 'multiadditem/multiadditem.dart';

class InfiniteScroll extends StatelessWidget {
  List<Object> items;
  Function updateQty;
  Function delete;

  InfiniteScroll(items, updateQty, delete) {
    this.items = items;
    this.updateQty = updateQty;
    this.delete = delete;
  }

  @override
  Widget build(BuildContext context) {
    // List<String> floufs = new List();

    return ListView.builder(
        itemCount: this.items.length,
        itemBuilder: (BuildContext context, int index) {
          dynamic item = this.items[index];
          return Container(
            constraints: BoxConstraints.tightFor(height: 150),
            child: MultiAddItem(int.parse(item['qty']), item['name'],
                item['expiryDate'], item['tip'], this.updateQty, this.delete),
          );
        });
  }
}
