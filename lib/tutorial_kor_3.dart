import 'package:dubu_timer/setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialKor3 extends StatefulWidget {
  TutorialKor3({Key? key}) : super(key: key);

  @override
  State<TutorialKor3> createState() => _TutorialKor3State();
}

class _TutorialKor3State extends State<TutorialKor3> {
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
                  '끝',
                  style: TextStyle(
                    fontFamily: 'gangwon',
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
                fontFamily: 'gangwon',
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
                child: Image.asset('assets/tutorial_kor_3.png')),
          ]),
        ),
      ),
    );
  }
}
