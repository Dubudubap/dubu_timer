import 'package:dubu_timer/tutorial_kor_3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'setting.dart';

class TutorialKor2 extends StatefulWidget {
  TutorialKor2({Key? key}) : super(key: key);

  @override
  State<TutorialKor2> createState() => _TutorialKor2State();
}

class _TutorialKor2State extends State<TutorialKor2> {
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
                  Get.to(() => TutorialKor3());
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
              '2/3',
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
                child: Image.asset('assets/tutorial_kor_2.png')),
          ]),
        ),
      ),
    );
  }
}
