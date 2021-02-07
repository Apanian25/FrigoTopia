// home screen contents
import 'package:app/src/screens/recipes/recipes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/src/screens/home/welcomeText/welcomeText.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            // appBar: AppBar(title: Text('Fridgotopia')),
            body: Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child:
                Image.asset('assets/images/welcome.png', fit: BoxFit.contain),
            constraints: BoxConstraints.expand(height: 200.0),
          ),
          WelcomeText(),
          Container(
            margin: EdgeInsets.all(20),
            child: ButtonTheme(
              minWidth: 200.0,
              height: 50.0,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                color: Color(0xff00BFA6),
                onPressed: () => Navigator.pushNamed(context, '/fridge'),
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
