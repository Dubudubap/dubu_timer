import 'package:dubu_timer/setting.dart';
import 'package:dubu_timer/tutorial_kor_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TutorialKor1 extends StatefulWidget {
  TutorialKor1({Key? key}) : super(key: key);

  @override
  State<TutorialKor1> createState() => _TutorialKor1State();
}

class _TutorialKor1State extends State<TutorialKor1> {
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
                  Get.to(() => TutorialKor2());
                },
                child: Text(
                  '다음',
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
              '1/3',
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
                child: Image.asset('assets/tutorial_kor_1.png')),
          ]),
        ),
      ),
    );
  }
}
