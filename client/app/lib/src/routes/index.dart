// routes for the app
import 'package:app/src/screens/home/index.dart';
import 'package:app/src/screens/fridge/fridge.dart';
import 'package:app/src/screens/camera/camera.dart';
import 'package:app/src/screens/multi-add/multiadd.dart';
import 'package:app/src/splash_screen.dart';
import 'package:flutter/material.dart';

final String json = '''
[
	{"confidence": "0.7913960814476013", "expiryDate": "2021-02-14", "name": "banana", "qty": "2", "tip": "Place in the fridge to give a longer lifespan!"}, 
	{"confidence": "0.776723325252533", "expiryDate": "2021-03-14", "name": "carrot", "qty": "1", "tip": "null"}, 
	{"confidence": "0.6791456937789917", "expiryDate": "2021-03-09", "name": "orange", "qty": "2", "tip": "null"}, 
	{"confidence": "0.6352046132087708", "expiryDate": "2021-02-12", "name": "broccoli", "qty": "1", "tip": "null"}, 
	{"confidence": "0.5347126126289368", "expiryDate": "2021-03-07", "name": "apple", "qty": "1", "tip": "null"}
]
''';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => HomeScreen());

    case '/fridge':
      return MaterialPageRoute(builder: (_) => Fridge());

    case '/camera':
      return MaterialPageRoute(builder: (_) => Camera(settings.arguments));

    case '/multiAdd':
      return MaterialPageRoute(builder: (_) => MultiAdd(json));
    //return MaterialPageRoute(builder: (_) => MultiAdd(settings.arguments));
    // case '/auth':
    //   return MaterialPageRoute(builder: (_) => AuthenticationScreen());
    default:
      return MaterialPageRoute(builder: (_) => SplashScreen());
  }
}
