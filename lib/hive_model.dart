import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 1)
class HiveModel {
  @HiveField(0)
  final int coins;

  @HiveField(1)
  final int totalTime;

  @HiveField(2)
  final List itemList;

  @HiveField(3)
  final int lang;

  HiveModel({
    required this.coins,
    required this.itemList,
    required this.totalTime,
    required this.lang,
  });
}
