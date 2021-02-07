import 'dart:math';

import 'package:app/src/screens/fridge/add_item.dart';
import 'package:app/src/screens/fridge/item_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// class CountersModel extends DataModel {
//   final counterUpState = StateWrapper();

//   int counterUp = 0;

//   void incrementCounterUp() {
//     counterUp++;
//     counterUpState.rebuild();
//   }

//   @override
//   void dispose() {}
// }

class ItemData {
  String name;
  String imagePath = "assets/images/logo.png";

  String tip;
  int quantity;

  int daysLeft;
  String expiryDate;
  String itemId;

  ItemData(
      {this.name,
      this.imagePath,
      this.tip,
      this.quantity,
      this.daysLeft,
      this.expiryDate,
      this.itemId});
}

class Item extends StatefulWidget {
  final ItemData itemData;
  final Function removeItem;
  final int maxHealthBarWidth = 50;
  Item({Key key, this.itemData, @required this.removeItem}) : super(key: key) {
    print(this.itemData.imagePath);
  }

  double getHealthBarWidthOnDay(int daysLeft) {
    return daysLeft * 50 / 14 > 50 ? 50.0 : (daysLeft * 50 / 14.0);
  }

  @override
  _ItemState createState() {
    print(this.itemData.imagePath);
    return _ItemState();
  }
}

class _ItemState extends State<Item> {
  double healthProgress;

  @override
  void initState() {
    super.initState();
    print('State: ${widget.itemData.daysLeft} ${widget.itemData.itemId}');
    // you can use this.widget.foo here
  }

  void showAddItemModal() {
    showCupertinoModalBottomSheet(
        context: context,
        enableDrag: true,
        // useRootNavigator: true,
        expand: true,
        builder: (context) => ItemForm(
            itemCard: new ItemCard(
              imagePath: widget.itemData.imagePath,
              showName: false,
              itemName: widget.itemData.name,
              color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                  .withOpacity(0.7),
              addItem: ({ItemData data = null}) {
                print('Updating item: ${data}');
              },
            ),
            isUpdating: true,
            removeItem: widget.removeItem,
            quantity: widget.itemData.quantity,
            daysLeft: widget.itemData.daysLeft,
            expiryDate: widget.itemData.expiryDate,
            itemId: widget.itemData.itemId //Switch to Update item
            // builder: (context) => SingleChildScrollView(
            //   controller: ModalScrollController.of(context),
            //   child: Container(),
            // ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: showAddItemModal,
        child: Column(children: [
          Container(
              constraints: BoxConstraints(
                  maxWidth:
                      widget.getHealthBarWidthOnDay(widget.itemData.daysLeft)),
              // margin: new EdgeInsets.fromLTRB(150.0, 0.0, 50.0, 0.0),
              child: LinearProgressIndicator(
                value: 1.0,
                valueColor: widget.itemData.daysLeft <= 3
                    ? AlwaysStoppedAnimation<Color>(Colors.red[600])
                    : widget.itemData.daysLeft > 3 &&
                            widget.itemData.daysLeft <= 8
                        ? AlwaysStoppedAnimation<Color>(Colors.yellow[600])
                        : AlwaysStoppedAnimation<Color>(Colors.green[600]),
              )),
          Image(
              image: AssetImage(widget.itemData.imagePath ??
                  'assets/images/food/icons8-celery-100.png'))
        ]));
  }
}
