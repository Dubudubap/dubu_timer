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
  String yourTitle(int time, int lang) {
    String _yourTitle = '';

    if (lang == 0) {
      _yourTitle = '아직은 어색한 사이';
    } else {
      _yourTitle = 'Stranger';
    }

    int milliseconds = time;
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
      timeStr = "$daysStr Day(s) $hoursStr Hour(s)\n$minsStr Minute(s)";
    }

    return timeStr;
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (item!.lang == 0)
                        ? Column(
                            children: [
                              Text(
                                '두부와의 관계',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'gangwon',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3, color: Colors.black87),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(13),
                                  ),
                                ),
                                child: Text(
                                  yourTitle(item.totalTime, item.lang),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'gangwon',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                'Relationship with Dubu',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'ShortStack',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3, color: Colors.black87),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(13),
                                  ),
                                ),
                                child: Text(
                                  yourTitle(item.totalTime, item.lang),
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
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        (item.lang == 0)
                            ? Text(
                                '전체 집중 시간',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'gangwon',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )
                            : Text(
                                'TOTAL FOCUS TIME',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'ShortStack',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                        SizedBox(height: 3.0),
                        (item.lang == 0)
                            ? Text(
                                transformMilliSeconds(
                                    item.totalTime, item.lang),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'gangwon',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              )
                            : Text(
                                transformMilliSeconds(
                                    item.totalTime, item.lang),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'ShortStack',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
