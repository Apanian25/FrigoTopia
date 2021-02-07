// routes for the app
import 'package:app/src/screens/home/index.dart';
import 'package:app/src/screens/fridge/fridge.dart';
import 'package:app/src/screens/camera/camera.dart';
import 'package:app/src/screens/multi-add/multiadd.dart';
import 'package:app/src/screens/recipes/recipes.dart';
import 'package:app/src/splash_screen.dart';
import 'package:flutter/material.dart';

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => HomeScreen());

    case '/fridge':
      return MaterialPageRoute(builder: (_) => Fridge());

    case '/camera':
      return MaterialPageRoute(builder: (_) => Camera(settings.arguments));

    case '/multiadd':
      return MaterialPageRoute(builder: (_) => MultiAdd(settings.arguments));
    //return MaterialPageRoute(builder: (_) => MultiAdd(settings.arguments));

    case '/recipe':
      return MaterialPageRoute(builder: (_) => Recipe(settings.arguments));
    // case '/auth':
    //   return MaterialPageRoute(builder: (_) => AuthenticationScreen());
    default:
      return MaterialPageRoute(builder: (_) => SplashScreen());
  }
}
