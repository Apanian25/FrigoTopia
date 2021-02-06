// home screen contents
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Fridgotopia')),
            body: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset('assets/images/welcome.png',
                        fit: BoxFit.contain),
                    constraints: BoxConstraints.expand(height: 200.0),
                  ),
                  Text(
                    'Frigotopia',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 30,
                          letterSpacing: .5),
                    ),
                  ),
                  Text(
                    'Keep your fridge in a good state',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          letterSpacing: .5),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ButtonTheme(
                      minWidth: 200.0,
                      height: 50.0,
                      child: RaisedButton(
                        color: Color(0xff00BFA6),
                        onPressed: () {},
                        child: Text(
                          "Go",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: .5),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
