import 'package:app/src/app.dart';
import 'package:flutter/material.dart';

import 'multiadditem/multiadditem.dart';

class InfiniteScroll extends StatefulWidget {
  List<Object> items;
  InfiniteScroll(items) {
    this.items = items;
  }

  @override
  InfiniteScrollState createState() => InfiniteScrollState(this.items);
}

class InfiniteScrollState extends State<InfiniteScroll> {
  List<Object> items;
  InfiniteScrollState(items) {
    this.items = items;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> floufs = new List();
    print(this.items);

    return ListView.builder(
        itemCount: this.items.length,
        itemBuilder: (BuildContext context, int index) {
          dynamic item = this.items[index];
          return Container(
            constraints: BoxConstraints.tightFor(height: 150),
            child: MultiAddItem(
                int.parse(item['qty']), item['name'], item['expiryDate']),
          );
        });
  }
}
