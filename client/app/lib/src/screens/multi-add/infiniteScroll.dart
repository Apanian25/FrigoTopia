import 'package:app/src/app.dart';
import 'package:flutter/material.dart';

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
    List<String> floufs = [
      'Kiss',
      'My',
      'Ass',
      'Kiss',
      'My',
      'Ass',
      'Kiss',
      'My',
      'Ass',
      'Kiss',
      'My',
      'Ass',
      'Kiss',
      'My',
      'Ass',
      'Kiss',
      'My',
      'Ass',
    ];

    return ListView.builder(
        itemCount: floufs.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            constraints: BoxConstraints.tightFor(height: 50),
            child: Text(floufs[index]),
          );
        });
  }
}
