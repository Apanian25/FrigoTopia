import 'package:app/src/screens/multi-add/infiniteScroll.dart';
import 'package:flutter/material.dart';

class MultiAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Add',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Multi-Add'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(child: Container(child: InfiniteScroll()), flex: 10),
              Flexible(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(child: Text("Total items: "), flex: 1),
                        Flexible(child: Text("6"), flex: 1)
                      ]),
                  flex: 1),
              Flexible(
                child: RaisedButton(
                  child: Text("Add Items"),
                  onPressed: () {
                    print("Button clicked");
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.greenAccent)),
                  color: Colors.green[200],
                  textColor: Colors.grey[900],
                ),
                flex: 1,
              )
            ]),
      ),
    );
  }
}
