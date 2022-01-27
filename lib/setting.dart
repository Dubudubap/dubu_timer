import 'package:flutter/material.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_url_preview/simple_url_preview.dart';

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

  bool value = false;

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    int days = (hours / 24).truncate();

    String hoursStr = (hours % 24).toString();
    String daysStr = days.toString();
    String minsStr = (minutes % 60).toString();
    String secsStr = (seconds % 60).toString();

    return "$daysStr Day(s) $hoursStr Hour(s)\n$minsStr Minute(s)\n$secsStr Seconds(s)";
  }

  convert(int value) {
    context.read()<Check>().convert(value);
  }

  @override
  Widget build(BuildContext context) {
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
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: (context.watch<Check>().check == 0)
                  ? () {
                      context.read<Check>().on();
                    }
                  : () {
                      context.read<Check>().off();
                    },
              child: (context.watch<Check>().check == 0)
                  ? Text(
                      'NO MEOW',
                      style: TextStyle(
                        fontFamily: 'Kitto',
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    )
                  : Text(
                      'MEOW',
                      style: TextStyle(
                        fontFamily: 'Kitto',
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
            ),
            Column(
              children: [
                Text(
                  'Your Focus Time',
                  style: TextStyle(fontFamily: 'Kitto', fontSize: 15),
                ),
                SizedBox(height: 3.0),
                Text(
                  transformMilliSeconds(context.watch<Times>().totalTime),
                  style: TextStyle(fontFamily: 'Kitto', fontSize: 15),
                ),
              ],
            ),
            OutlinedButton(
                onPressed: () {
                  openURL();
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  side: MaterialStateProperty.all(
                      BorderSide(color: Colors.black87, width: 3)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                ),
                child: SizedBox(
                  width: 120,
                  height: 20,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/camera.png',
                          height: 20,
                          width: 20,
                        ),
                        Text('@dubudubap',
                            style: TextStyle(
                              fontFamily: 'Kitto',
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            )),
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
