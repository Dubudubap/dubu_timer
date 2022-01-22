import 'package:dubu_timer/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dubu_timer/provider/global_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counts()),
        ChangeNotifierProvider(create: (_) => Times()),
        ChangeNotifierProvider(create: (_) => Check()),
        ChangeNotifierProvider(create: (_) => Item()),
        ChangeNotifierProvider<ListProvider>(
            create: (context) => ListProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
