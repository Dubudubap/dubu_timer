import 'package:dubu_timer/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dubu_timer/shopping.dart';
import 'package:dubu_timer/coin.dart';

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
        lang: context.read<Lang>().lang,
      ),
    );
    print(ownedItems.GetItems());
  }

  Widget buildShoppingCard(shopping Shopping) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<HiveModel>('hiveModel').listenable(),
        builder: (context, Box<HiveModel> box, child) {
          final item = box.getAt(0);
          return Column(children: [
            SizedBox(
              height: 270,
              width: 270,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Image(image: AssetImage(Shopping.imageUrl)),
                    ],
                  ),
                ),
              ),
            ),
            OutlinedButton(
              onPressed: Shopping.inStock == true &&
                      item!.coins >= Shopping.price &&
                      (item.itemList.contains(Shopping.num) == false)
                  ? () {
                      context.read<Counts>().update(item.coins.toDouble());
                      context.read<Counts>().remove(Shopping.price.toDouble());
                      Shopping.inStock = false;
                      context.read<ListProvider>().Update(item.itemList);
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
                    BorderSide(color: Colors.black87, width: 2)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                )),
              ),
              child: (ownedItems.contains(Shopping.num) |
                      item!.itemList.contains(Shopping.num))
                  ? (item.lang == 0)
                      ? Text(
                          '소유중',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'gangwon',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )
                      : Text(
                          'OWNED',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'ShortStack',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )
                  : Text(
                      '${Shopping.price}',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'ShortStack',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
            ),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<HiveModel>('hiveModel').listenable(),
        builder: (context, Box<HiveModel> box, child) {
          final item = box.getAt(0);
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      context
                          .read<Counts>()
                          .update(box.getAt(0)!.coins.toDouble());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => coin()));
                    },
                    icon: Image.asset('assets/coinPlus.png'),
                    iconSize: 10,
                  ),
                  Text(
                    item!.coins.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'ShortStack',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
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
        });
  }
}
