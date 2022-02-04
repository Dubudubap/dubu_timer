import 'package:dubu_timer/homePage.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:dubu_timer/provider/global_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hive_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  await Hive.openBox<HiveModel>('hiveModel');
  MobileAds.instance.initialize();
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
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
