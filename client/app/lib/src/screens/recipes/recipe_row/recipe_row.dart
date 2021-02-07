// home screen contents
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeRow extends StatelessWidget {
  String _url;
  String _title;
  String _img;
  String _src;

  RecipeRow(String url, String title, String img, String src) {
    _url = url;
    _title = title;
    _img = img;
    _src = src;
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () async {
          if (await canLaunch(_url)) {
            await launch(
              _url,
              forceSafariVC: false,
            );
          }
        },
        child: Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            margin: EdgeInsets.only(top: 10.0, bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(225, 240, 225, 1),
                border: Border.all(
                  color: Colors.black87,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Image.network(_img),
                    width: 100,
                    height: 50,
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
                                _title,
                                textDirection: TextDirection.ltr,
                                maxLines: 2,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: .5),
                                ),
                              )),
                          Text(
                            'By: ' + _src,
                            textDirection: TextDirection.ltr,
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
            )));
  }
}
