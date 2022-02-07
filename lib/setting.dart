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

  String yourTitle() {
    String _yourTitle = 'STRANGER';

    int milliseconds = context.read<Times>().totalTime;
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    if (10 > hours && hours >= 1) {
      _yourTitle = 'BABY BUTLER';
    } else if (100 > hours && hours >= 10) {
      _yourTitle = 'JUNIOR BUTLER';
    } else if (500 > hours && hours >= 100) {
      _yourTitle = 'SENIOR BUTLER';
    } else if (1000 > hours && hours >= 500) {
      _yourTitle = 'MASTER BUTLER';
    } else if (hours >= 1000) {
      _yourTitle = 'A KING OF BUTLERS';
    }

    return _yourTitle;
  }

  bool value = false;

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
                  yourTitle(),
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'ShortStack',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: () => openURL(),
              icon: Image.asset('assets/insta.png'),
              iconSize: 15,
            )
          ],
        ),
      ),
    );
  }
}
