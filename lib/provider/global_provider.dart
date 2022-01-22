import 'package:flutter/material.dart';

class Counts with ChangeNotifier {
  double _count = 0;
  double get count => _count;

  void add(double cost) {
    _count = _count + cost;
    notifyListeners();
  }

  void remove(double cost) {
    _count = _count - cost;
    notifyListeners();
  }
}

class Times with ChangeNotifier {
  int _totalTime = 0;
  int get totalTime => _totalTime;

  void timeAdd(int elapsedtime) {
    _totalTime = elapsedtime + _totalTime;
    notifyListeners();
  }
}

class Check with ChangeNotifier {
  int _check = 0;
  int get check => _check;

  void on() {
    _check = 1;
    notifyListeners();
  }

  void off() {
    _check = 0;
    notifyListeners();
  }
}

class ListProvider extends ChangeNotifier {
  List<int> items = [0];

  void addItem(int item) {
    items.add(item);
    notifyListeners();
  }

  bool contains(int item) {
    bool answer = items.contains(item);
    return answer;
  }

  int Length() {
    return items.length;
  }

  List<int> GetItems() {
    return items;
  }
}

class DynamicList {
  List<int> _item = [];
  DynamicList(this._item);

  List get item => _item;
}

class Item extends ChangeNotifier {
  int itemNum = 0;

  UpdateValue(int length) {
    this.itemNum = length;
    notifyListeners();
  }
}

class ItemList {
  List<String> itemList = [
    'assets/null.png',
    'assets/space.png',
    'assets/rocket.png',
    'assets/punky.png',
    'assets/gentleHat.png',
    'assets/ribbon.png'
  ];
}
