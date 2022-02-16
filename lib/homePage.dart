import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:dubu_timer/hive_model.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:dubu_timer/shop.dart';
import 'package:dubu_timer/setting.dart';
import 'package:dubu_timer/pomodoro.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dubu_timer/statistic.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List ownedItems = [];
  var closet;
  late DynamicList listClass;

  @override
  void initState() {
    super.initState();
    closet = Provider.of<ListProvider>(context, listen: false);
    listClass = DynamicList(closet.items);
  }

  var goods = 'assets/null.png';

  void PlaySound(String soundName) {
    final _player = AudioCache();
    _player.play(soundName);
  }

  Future<void> SaveModelValue() async {
    final box = await Hive.box<HiveModel>('hiveModel');
    int id = 1;
    if (box.isNotEmpty) {
      final Item = box.getAt(0);
    }
    box.put(
      id,
      HiveModel(
        coins: context.read<Counts>().count.floor(),
        totalTime: context.read<Times>().totalTime,
        itemList: closet.GetItems(),
        lang: context.read<Lang>().lang,
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => ListProvider(),
        child: ValueListenableBuilder(
            valueListenable: Hive.box<HiveModel>('hiveModel').listenable(),
            builder: (context, Box<HiveModel> box, child) {
              if (box.isEmpty) {
                SaveModelValue();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        alignment: Alignment.topRight,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => setting()));
                        },
                        icon: Image.asset('assets/gear.png'),
                        iconSize: 20,
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Statistic()));
                        },
                        icon: Image.asset('assets/statistic.png'),
                        iconSize: 20,
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/White_Ca.png',
                        height: 270,
                        width: 270,
                      ),
                      Image.asset(
                        goods,
                        height: 270,
                        width: 270,
                      ),
                      IconButton(
                        onPressed: (context.watch<Check>().check == 1)
                            ? () {
                                PlaySound('meow.m4a');
                              }
                            : null,
                        splashColor: Colors.white,
                        highlightColor: Colors.white,
                        icon: Image.asset('assets/null.png'),
                        iconSize: 270,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => shop()));
                        },
                        icon: Image.asset('assets/ropa.png'),
                        iconSize: 20,
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          closet.Update(box.getAt(0)!.itemList);
                          Swapping();
                        },
                        icon: Image.asset('assets/refresh.png'),
                        iconSize: 20,
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          context.read<Times>().update(box.getAt(0)!.totalTime);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Pomodoro()));
                        },
                        icon: Image.asset('assets/clock.png'),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
      backgroundColor: Colors.white,
    );
  }

  Swapping() {
    Random random = Random();
    var itemStocks = random.nextInt(closet.Length());
    ownedItems = closet.GetItems();
    var itemIndex = ownedItems[itemStocks];
    setState(() {
      goods = ItemList().itemList[itemIndex];
    });
  }
}
