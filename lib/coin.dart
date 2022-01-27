import 'package:dubu_timer/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class coin extends StatefulWidget {
  const coin({Key? key}) : super(key: key);

  @override
  _coinState createState() => _coinState();
}

class _coinState extends State<coin> {
  List Items = [];
  var closet;
  late DynamicList listClass;

  @override
  void initState() {
    super.initState();
    closet = Provider.of<ListProvider>(context, listen: false);
    listClass = DynamicList(closet.items);
  }

  Future<void> SaveModelValue() async {
    final box = await Hive.box<HiveModel>('hiveModel');
    int id = 1;
    if (box.isNotEmpty) {
      final Item = box.getAt(0);
    }
    Items = closet.GetItems();
    box.put(
      id,
      HiveModel(
        coins: context.read<Counts>().count.floor(),
        totalTime: context.read<Times>().totalTime,
        itemList: Items,
      ),
    );
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
                icon: Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'You Have',
                style: TextStyle(fontFamily: 'Kitto'),
              ),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/coin.png',
                      height: 20,
                      width: 20,
                    ),
                    Text(
                      '  ' + item!.coins.toString(),
                      style: TextStyle(fontFamily: 'Kitto', fontSize: 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Donate for Animal Associations!',
                    style: TextStyle(fontSize: 15, fontFamily: 'Kitto'),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      print('donate');
                    },
                    child: Text(
                      'DONATE',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Kitto',
                          color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ]),
          );
        });
  }
}
