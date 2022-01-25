import 'package:dubu_timer/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dubu_timer/shopping.dart';

class shop extends StatefulWidget {
  const shop({Key? key}) : super(key: key);

  @override
  _shopState createState() => _shopState();
}

class _shopState extends State<shop> {
  bool inStock = true;
  var ownedItems;
  late DynamicList listClass;

  @override
  void initState() {
    super.initState();
    ownedItems = Provider.of<ListProvider>(context, listen: false);
    listClass = DynamicList(ownedItems.items);
  }

  Future<void> SaveModelValue() async {
    final box = await Hive.box<HiveModel>('hiveModel');
    int id = 1;
    if (box.isNotEmpty) {
      final Item = box.getAt(0);
      print(id);
    }
    box.put(
      id,
      HiveModel(
        coins: context.read<Counts>().count.floor(),
        totalTime: context.read<Times>().totalTime,
        itemList: ownedItems.GetItems(),
      ),
    );
    print(ownedItems.GetItems());
  }

  Widget buildShoppingCard(shopping Shopping) {
    return Column(children: [
      Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(
              color: Colors.black,
              width: 5.0,
            )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Image(image: AssetImage(Shopping.imageUrl)),
            ],
          ),
        ),
      ),
      OutlinedButton(
          onPressed:
              Shopping.inStock == true && context.watch<Counts>().count >= 3600
                  ? () {
                      context.read<Counts>().remove(3600);
                      Shopping.inStock = false;
                      ownedItems.addItem(Shopping.num);
                      context.read<Item>().UpdateValue(ownedItems.Length());
                      SaveModelValue();
                    }
                  : () {
                      Shopping.inStock = true;
                    },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(
                BorderSide(color: Colors.black87, width: 4)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            )),
          ),
          child: ownedItems.contains(Shopping.num)
              ? Text('Owned',
                  style: TextStyle(
                    fontFamily: 'Kitto',
                    color: Colors.black87,
                  ))
              : Text('Buy',
                  style: TextStyle(
                    fontFamily: 'Kitto',
                    color: Colors.black87,
                  )))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            print(ownedItems);
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: shopping.samples.length,
          itemBuilder: (BuildContext context, int index) {
            return buildShoppingCard(shopping.samples[index]);
          },
        ),
      ),
    );
  }
}
