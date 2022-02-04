import 'package:flutter/material.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

    return "$daysStr Day(s) $hoursStr Hour(s)\n$minsStr Minute(s)";
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
                        fontSize: 15,
                        fontFamily: 'ShortStack',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    )
                  : Text(
                      'MEOW',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'ShortStack',
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FRESH BUTLER',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'ShortStack',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  'Your Focus Time',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'ShortStack',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  transformMilliSeconds(context.watch<Times>().totalTime),
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'ShortStack',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () => openURL(),
              icon: Image.asset('assets/camera.png'),
              iconSize: 15,
            )
          ],
        ),
      ),
    );
  }
}
