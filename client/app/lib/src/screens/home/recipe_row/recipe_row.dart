// home screen contents
import 'package:flutter/material.dart';
import 'package:app/src/screens/fridge/food_item_image.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeRow extends StatelessWidget {
  RecipeRow() {}

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Image.network(
                'https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg'),
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
                        "Chicken something something",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: .5),
                        ),
                      )),
                  Text(
                    'By: BBC',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .5),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
