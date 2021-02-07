import 'dart:convert';

import 'package:app/src/screens/multi-add/infiniteScroll.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiAdd extends StatelessWidget {
  List<dynamic> items;

  MultiAdd(items) {
    this.items = jsonDecode(items);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Validate Options'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: Container(child: InfiniteScroll(this.items)),
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
                                      "Totel Items: 6",
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
                                  print("press");
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
