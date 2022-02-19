import 'package:dubu_timer/homePage.dart';
import 'package:dubu_timer/tutorial_eng_1.dart';
import 'package:dubu_timer/tutorial_kor_1.dart';
import 'package:flutter/material.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dubu_timer/hive_model.dart';
import 'package:get/get.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  openURL() async {
    if (await canLaunch('https://www.instagram.com/dubudubap')) {
      await launch('https://www.instagram.com/dubudubap');
    } else {
      throw 'Could Not Launch URL';
    }
  }

  review() async {
    if (await canLaunch(
        'https://play.google.com/store/apps/details?id=com.dubu.dubu_timer')) {
      await launch(
          'https://play.google.com/store/apps/details?id=com.dubu.dubu_timer');
    } else {
      throw 'Could Not Launch URL';
    }
  }

  String yourTitle(int lang) {
    String _yourTitle = '';

    if (lang == 0) {
      _yourTitle = '아직은 어색한 사이';
    } else {
      _yourTitle = 'Stranger';
    }

    int milliseconds = context.read<Times>().totalTime;
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    if (10 > hours && hours >= 1) {
      if (lang == 0) {
        _yourTitle = '아기 집사';
      } else {
        _yourTitle = 'BABY BUTLER';
      }
    } else if (100 > hours && hours >= 10) {
      if (lang == 0) {
        _yourTitle = '풋내기 집사';
      } else {
        _yourTitle = 'JUNIOR BUTLER';
      }
    } else if (500 > hours && hours >= 100) {
      if (lang == 0) {
        _yourTitle = '노련한 집사';
      } else {
        _yourTitle = 'SENIOR BUTLER';
      }
    } else if (1000 > hours && hours >= 500) {
      if (lang == 0) {
        _yourTitle = '마스터 집사';
      } else {
        _yourTitle = 'MASTER BUTLER';
      }
    } else if (hours >= 1000) {
      if (lang == 0) {
        _yourTitle = '가족';
      } else {
        _yourTitle = 'Family';
      }
    }

    return _yourTitle;
  }

  bool value = false;

  convert(int value) {
    context.read()<Check>().convert(value);
  }

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
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<HiveModel>('hiveModel').listenable(),
        builder: (context, Box<HiveModel> box, child) {
          final item = box.getAt(0);
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.to(() => HomePage()),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 5,
                        side: BorderSide(width: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 10,
                          bottom: 10,
                        ),
                      ),
                      onPressed: (context.watch<Check>().check == 0)
                          ? () {
                              context.read<Check>().on();
                            }
                          : () {
                              context.read<Check>().off();
                            },
                      child: (context.watch<Check>().check == 0)
                          ? (item!.lang == 0)
                              ? Text(
                                  '소리: 끔',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'gangwon',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                )
                              : Text(
                                  'Sound: off',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'ShortStack',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                )
                          : (item!.lang == 0)
                              ? Text(
                                  '소리: 켬',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'gangwon',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                )
                              : Text(
                                  'Sound: on',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'ShortStack',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                    ),
                    Column(
                      children: [
                        (item.lang == 0)
                            ? Text(
                                '언어',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'gangwon',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )
                            : Text(
                                'Language',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'ShortStack',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 5,
                            side: BorderSide(width: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                          ),
                          onPressed: (item.lang == 0)
                              ? () {
                                  context.read<Lang>().toEng();
                                  context.read<Times>().update(item.totalTime);
                                  context
                                      .read<Counts>()
                                      .update(item.coins.toDouble());
                                  SaveModelValue();
                                }
                              : () {
                                  context.read<Lang>().toKor();
                                  context.read<Times>().update(item.totalTime);
                                  context
                                      .read<Counts>()
                                      .update(item.coins.toDouble());
                                  SaveModelValue();
                                },
                          child: (item.lang == 0)
                              ? Text(
                                  '한글',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'gangwon',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                )
                              : Text(
                                  'English',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'ShortStack',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 5,
                        side: BorderSide(width: 3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                      ),
                      onPressed: (item.lang == 0)
                          ? () {
                              Get.to(() => TutorialKor1());
                            }
                          : () {
                              Get.to(() => TutorialEng1());
                            },
                      child: (item.lang == 0)
                          ? Text(
                              '안내서',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'gangwon',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            )
                          : Text(
                              'Tutorial',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'ShortStack',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                    ),
                    IconButton(
                      onPressed: () {
                        review();
                      },
                      icon: Image.asset('assets/star.png'),
                      iconSize: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        if (box.getAt(0)!.itemList.contains(19) == false) {
                          closet.addItem(19);
                          context.read<Item>().UpdateValue(closet.Length());
                          SaveModelValue();
                        }
                        openURL();
                      },
                      icon: Image.asset('assets/insta.png'),
                      iconSize: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
