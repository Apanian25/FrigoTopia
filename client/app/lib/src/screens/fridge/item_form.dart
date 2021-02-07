import 'package:app/src/screens/fridge/add_item.dart';
import 'package:app/src/screens/fridge/item.dart';
import 'package:flutter/material.dart';
import 'package:app/src/utils/string_util.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemForm extends StatefulWidget {
  final Function addItem;
  final Function removeItem;
  final ItemCard itemCard;
  final bool isUpdating;
  final int quantity;
  final int daysLeft;
  final String itemId;
  final String expiryDate;

  ItemForm(
      {this.addItem,
      @required this.itemCard,
      this.isUpdating = false,
      this.itemId,
      this.removeItem,
      this.quantity,
      this.daysLeft,
      this.expiryDate});

  @override
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  ItemData data;

  String convertDate(DateTime now) {
    return "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    print("DATA ${widget.expiryDate}");
    data = new ItemData(
        daysLeft: widget.daysLeft ?? 7,
        imagePath: widget.itemCard.imagePath,
        quantity: widget.quantity ?? 1,
        name: widget.itemCard.itemName,
        itemId: widget.itemId);
    data.expiryDate =
        convertDate(new DateTime.now().add(new Duration(days: data.daysLeft)));
  }

  @override
  Widget build(BuildContext context) {
    var addButton = RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color(0000000))),
      onPressed: () {
        widget.itemCard.addItem(data: data);
        Navigator.pop(context);
        // Navigator.popUntil(context, ModalRoute.withName('/fridge'));
      },
      color: Color(0xffa6e4a6),
      textColor: Color(0xff396339),
      child: Text("Add Item", style: TextStyle(fontSize: 14)),
    );
    var removeButton = RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color(0000000))),
      onPressed: () {
        print("Removing ${data.name}");
        widget.removeItem(data: data);
        Navigator.pop(context);
      },
      color: Colors.red[600],
      textColor: Color(0xff396339),
      child: Text("Remove Item", style: TextStyle(fontSize: 14)),
    );
    var updateButton = RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Color(0000000))),
      onPressed: () {
        widget.itemCard.addItem(data: data);
        Navigator.pop(context);
      },
      color: Colors.yellow[600],
      textColor: Color(0xff396339),
      child: Text("Update Item", style: TextStyle(fontSize: 14)),
    );
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            flex: 1,
            child: Container(
                padding: const EdgeInsets.only(
                    right: 10.0, left: 10.0, top: 15.0, bottom: 15.0),
                alignment: Alignment.centerLeft,
                child: Text("${widget.isUpdating ? 'Update' : 'Add'} an item:",
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
                            padding: const EdgeInsets.only(
                                right: 10.0,
                                left: 10.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Center(
                                child: Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Days left:',
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5),
                                    ),
                                    textAlign: TextAlign.left,
                                  )),
                              Expanded(
                                  flex: 8,
                                  child: Slider(
                                    value: data.daysLeft * 1.0,
                                    min: 0,
                                    max: 40,
                                    divisions: 40,
                                    label: (data.daysLeft * 1.0)
                                        .round()
                                        .toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        data.daysLeft = value.round();
                                        data.expiryDate = convertDate(
                                            new DateTime.now().add(new Duration(
                                                days: data.daysLeft)));
                                      });
                                    },
                                  ))
                            ]))),
                        Container(
                            padding: const EdgeInsets.only(
                                right: 10.0,
                                left: 10.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Center(
                                child: Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Quantity:',
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5),
                                    ),
                                    textAlign: TextAlign.left,
                                  )),
                              Expanded(
                                  flex: 8,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.remove,
                                              color: Colors.black54, size: 20),
                                          onPressed: () => setState(() {
                                                if (data.quantity > 0) {
                                                  data.quantity =
                                                      data.quantity - 1;
                                                }
                                              })),
                                      Text(data.quantity.toString(),
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: .5),
                                          )),
                                      IconButton(
                                          icon: Icon(Icons.add,
                                              color: Colors.black54, size: 20),
                                          onPressed: () => setState(() {
                                                data.quantity =
                                                    data.quantity + 1;
                                              }))
                                    ],
                                  ))
                            ]))),
                        Container(
                            padding: const EdgeInsets.only(
                                right: 10.0,
                                left: 10.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Center(
                                child: Row(children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Expired Date:',
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .5),
                                    ),
                                    textAlign: TextAlign.left,
                                  )),
                              Expanded(
                                  flex: 8,
                                  child: Row(
                                    children: [
                                      Spacer(
                                        flex: 2,
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: FlatButton(
                                          child: Text(
                                              data.expiryDate.toString(),
                                              style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.black54,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: .5),
                                              )),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ))
                            ]))),
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
                child: widget.isUpdating
                    ? Row(
                        children: [
                          Expanded(child: updateButton, flex: 45),
                          Spacer(flex: 10),
                          Expanded(child: removeButton, flex: 45)
                        ],
                      )
                    : addButton)),
      ],
    ));
  }
}
