import 'package:app/src/app.dart';
import 'package:flutter/material.dart';

class InfiniteScroll extends StatefulWidget {
  final String text;
  const InfiniteScroll({this.text});

  @override
  InfiniteScrollState createState() => InfiniteScrollState();
}

class InfiniteScrollState extends State<InfiniteScroll> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<String> floufs = new List();
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
