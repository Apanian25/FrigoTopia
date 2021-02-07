import 'package:app/src/screens/recipes/scroller.dart';
import 'package:flutter/material.dart';

class Recipe extends StatefulWidget {
  List<dynamic> items;

  Recipe(items) {
    // this.items = jsonDecode(items);
    this.items = [
      {
        'url':
            "https://www.sargento.com/recipes/dinner/chicken-tortilla-wraps/",
        'title': "Chicken Tortilla",
        'img':
            "https://d1bjorv296jxfn.cloudfront.net/s3fs-public/recipe-images/sargento/chix-wrap.jpg",
        'src': "Sagento",
      },
      {
        'url': "https://cafedelites.com/chicken-tikka-masala/",
        'title': "Chicken Masalla",
        'img':
            "https://cafedelites.com/wp-content/uploads/2018/04/Best-Chicken-Tikka-Masala-IMAGE-2.jpg",
        'src': "Cafe Delites",
      }
    ];
  }

  @override
  _Recipe createState() => new _Recipe(this.items);
}

class _Recipe extends State<Recipe> {
  List<dynamic> _items;
  _Recipe(items) {
    _items = items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flexible(child: Scroller(items: _items), flex: 1),
    );
  }
}
