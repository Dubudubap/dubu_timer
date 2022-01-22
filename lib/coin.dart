import 'package:flutter/material.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:provider/provider.dart';

class coin extends StatefulWidget {
  const coin({Key? key}) : super(key: key);

  @override
  _coinState createState() => _coinState();
}

class _coinState extends State<coin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'You Have',
          style: TextStyle(fontFamily: 'Kitto'),
        ),
        Container(
          height: 20,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/coin.png',
                height: 20,
                width: 20,
              ),
              Text(
                '  ' + context.watch<Counts>().count.floor().toString(),
                style: TextStyle(fontFamily: 'Kitto', fontSize: 15),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Donate for Animal Associations!',
              style: TextStyle(fontSize: 15, fontFamily: 'Kitto'),
            ),
            SizedBox(
              height: 3,
            ),
            OutlinedButton(
              onPressed: () {
                print('donate');
              },
              child: Text(
                'DONATE',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Kitto', color: Colors.black87),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                context.read<Counts>().add(3600);
              },
              child: Text(
                '3600coins',
                style: TextStyle(
                    fontSize: 20, fontFamily: 'Kitto', color: Colors.black87),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
