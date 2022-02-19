import 'package:dubu_timer/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialEng3 extends StatefulWidget {
  TutorialEng3({Key? key}) : super(key: key);

  @override
  State<TutorialEng3> createState() => _TutorialEng3State();
}

class _TutorialEng3State extends State<TutorialEng3> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 3,
                  ),
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  Get.to(() => setting());
                },
                child: Text(
                  'end',
                  style: TextStyle(
                    fontFamily: 'ShortStack',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(children: [
            Text(
              '3/3',
              style: TextStyle(
                fontFamily: 'ShortStack',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: Colors.black87),
                ),
                child: Image.asset('assets/tutorial_eng_3.png')),
          ]),
        ),
      ),
    );
  }
}
