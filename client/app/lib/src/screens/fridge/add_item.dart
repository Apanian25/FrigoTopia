import 'dart:math';

import 'package:app/src/screens/fridge/food_item_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ItemCard extends StatelessWidget {
  final color = Colors.primaries[Random().nextInt(Colors.primaries.length)]
      .withOpacity(0.7);
  final String itemName;
  final String imagePath;

  ItemCard({@required this.itemName, @required this.imagePath});

  Widget build(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        height: 60,
        // child: new Center(
        child: Card(
            margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
            elevation: 0.0,
            // margin: EdgeInsets.,
            color: color,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Container(
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: Image.asset(imagePath ??
                                'assets/images/food/icons8-celery-100.png'),
                          ),
                          flex: 4,
                        ),
                        Expanded(
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Color(0xffa6e4a6)),
                            child: Center(
                                child: Text(
                              itemName,
                            )),
                          ),
                          flex: 1,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 8.0),
                        //   child: Text(
                        //     itemName,
                        //   ),
                        // ),
                      ])),
            )));
  }
}

class AddItemModal extends StatefulWidget {
  // BuildContext context;

  // AddItemModal({@required BuildContext context});
  @override
  _AddItemModalState createState() => _AddItemModalState();
}

class _AddItemModalState extends State<AddItemModal> {
  List<Map> initialList = new List<Map>.generate(8, (i) {
    var key = Random().nextInt(foodList.length);
    return foodList[key];
  });

  @override
  Widget build(BuildContext context) {
    print(initialList[0]);
    return Scaffold(
        body: SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Container(
        child: Center(
          child: Column(
            children: [
              Row(children: [
                Container(
                    padding: const EdgeInsets.only(
                        right: 8.0, left: 8.0, top: 15.0, bottom: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Text("Add an item:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )))
              ]),
              // Row(children: [
              Container(
                  padding: const EdgeInsets.only(
                      right: 8.0, left: 8.0, top: 10.0, bottom: 10.0),
                  child: Center(
                      child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Search',
                      labelStyle: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w400),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(width: 0, color: Color(00000000))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                              BorderSide(width: 0, color: Color(00000000))),
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(10.0),
                      //     borderSide: BorderSide(width: 0, color: Color(00000000))),
                      filled: true,
                      fillColor: Colors.grey[300],
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.teal,
                        size: 30.0,
                        semanticLabel: 'Search',
                      ),
                    ),
                  )))
              // ]),
              ,
              new Padding(
                padding: const EdgeInsets.all(4.0),
                child: new StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemCard(
                        itemName: initialList[index]['name'],
                        imagePath: initialList[index]['imagePath']);
                  },
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(2, index.isEven ? 2.2 : 1.8),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
