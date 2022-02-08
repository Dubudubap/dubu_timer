import 'package:flutter/material.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dubu_timer/hive_model.dart';

class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  _StatisticState createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  transformMilliSeconds(int milliseconds, int lang) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    int days = (hours / 24).truncate();

    String hoursStr = (hours % 24).toString();
    String daysStr = days.toString();
    String minsStr = (minutes % 60).toString();
    String secsStr = (seconds % 60).toString();

    String timeStr = '';

    if (lang == 0) {
      timeStr = "$daysStr 일 $hoursStr 시간 $minsStr 분";
    } else {
      timeStr = "$daysStr Day(s) $hoursStr Hour(s) $minsStr Minute(s)";
    }

    return timeStr;
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
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      (item!.lang == 0)
                          ? Text(
                              '전체 집중 시간',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'gangwon',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            )
                          : Text(
                              'TOTAL FOCUS TIME',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'ShortStack',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                      SizedBox(height: 3.0),
                      (item.lang == 0)
                          ? Text(
                              transformMilliSeconds(item.totalTime, item.lang),
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'gangwon',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            )
                          : Text(
                              transformMilliSeconds(item.totalTime, item.lang),
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'ShortStack',
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
