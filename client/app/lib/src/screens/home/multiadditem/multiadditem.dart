// home screen contents
import 'package:flutter/material.dart';
import 'package:app/src/screens/fridge/food_item_image.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiAddItem extends StatefulWidget {
  @override
  _MultiAddItem createState() => new _MultiAddItem();
}

class _MultiAddItem extends State<MultiAddItem> {
  int _qty = 1;
  String _name = 'Banana';
  String _expiryDate = '2021-02-11';

  @override
  Widget build(BuildContext context) {
    String foodType = _name.toLowerCase();
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            child: Image.asset(foodDict[foodType]),
            decoration: BoxDecoration(
                color: Color.fromRGBO(225, 240, 225, 1),
                // border: Border.all(
                //   color: Colors.black87,
                // ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
              margin: EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        _name,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5),
                        ),
                      )),
                  Text(
                    'Expires: ' + _expiryDate,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => setState(() {
                                if (_qty > 0) {
                                  _qty = _qty - 1;
                                }
                              })),
                      Text(_qty.toString(),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: .5),
                          )),
                      IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => setState(() {
                                _qty = _qty + 1;
                              }))
                    ],
                  ),
                ],
              )),
        ),
        Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 85.0),
              child: IconButton(
                icon: Icon(Icons.delete_forever, color: Colors.red[700]),
              ),
            ))
      ],
    );
  }
}
