import 'package:app/src/screens/fridge/add_item.dart';
import 'package:app/src/screens/fridge/item.dart';
import 'package:flutter/material.dart';
import 'package:app/src/utils/string_util.dart';

class ItemForm extends StatefulWidget {
  final Function addItem;
  final ItemCard itemCard;

  ItemForm({@required this.addItem, @required this.itemCard});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  ItemData data;
  double _currentSliderValue = 0;
  @override
  void initState() {
    super.initState();
    data = new ItemData(
      daysLeft: 7,
      imagePath: widget.itemCard.imagePath,
      quantity: 1,
      name: widget.itemCard.itemName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.only(
                    right: 10.0, left: 10.0, top: 15.0, bottom: 15.0),
                alignment: Alignment.centerLeft,
                child: Text("Add an item:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.black,
                        decoration: TextDecoration.none)))),
        Expanded(
            flex: 2,
            child: Container(
                child: ItemCard(
                    itemName: widget.itemCard.itemName,
                    imagePath: widget.itemCard.imagePath,
                    addItem: widget.itemCard.addItem,
                    color: widget.itemCard.color,
                    showName: false))),
        Expanded(
            flex: 6,
            child: Container(
                child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.only(
                          right: 10.0, left: 10.0, top: 0.0, bottom: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Text(data.name.capitalizeFirstofEach,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                              color: Colors.black,
                              decoration: TextDecoration.none)),
                    )),
                // Expanded(flex: 1, child: ,)
                Expanded(
                    flex: 8,
                    child: Column(
                      children: [
                        Container(
                            child: Slider(
                          value: _currentSliderValue,
                          min: 0,
                          max: 100,
                          divisions: 5,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                        ))
                      ],
                    ))
              ],
            ))),
        Expanded(
            flex: 1,
            child: Container(
                constraints: BoxConstraints.expand(),
                padding: const EdgeInsets.only(
                    right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color(0000000))),
                  onPressed: () {
                    widget.itemCard.addItem();
                  },
                  color: Color(0xffa6e4a6),
                  textColor: Color(0xff396339),
                  child: Text("Add Item", style: TextStyle(fontSize: 14)),
                ))),
      ],
    ));
  }
}
