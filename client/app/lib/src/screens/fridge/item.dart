import 'package:app/src/screens/fridge/add_item.dart';
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
  DateTime expiryDate;

  ItemData(
      {this.name,
      this.imagePath,
      this.tip,
      this.quantity,
      this.daysLeft,
      this.expiryDate});
}

class Item extends StatefulWidget {
  final ItemData itemData;
  Item({Key key, this.itemData}) : super(key: key) {
    print(this.itemData.imagePath);
  }

  @override
  _ItemState createState() {
    print(this.itemData.imagePath);
    return _ItemState();
  }
}

class _ItemState extends State<Item> {
  @override
  void initState() {
    super.initState();
    print('State: ${widget.itemData}');
    // you can use this.widget.foo here
  }

  void showAddItemModal() {
    showCupertinoModalBottomSheet(
      context: context,
      enableDrag: true,
      // useRootNavigator: true,
      expand: true,
      builder: (context) => AddItemModal(),
      // builder: (context) => SingleChildScrollView(
      //   controller: ModalScrollController.of(context),
      //   child: Container(),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: showAddItemModal,
        child: Image(
            image: AssetImage(widget.itemData.imagePath ??
                'assets/images/food/icons8-celery-100.png')));
  }
}
