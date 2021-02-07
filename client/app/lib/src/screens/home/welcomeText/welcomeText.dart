// home screen contents
import 'package:app/src/screens/home/multiadditem/multiadditem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(
          'Frigotopia',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
                color: Colors.black54, fontSize: 30, letterSpacing: .5),
          ),
        ),
        Text(
          'Keep your fridge in a good state',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
                color: Colors.black54, fontSize: 16, letterSpacing: .5),
          ),
        ),
      ],
    ));
  }
}
