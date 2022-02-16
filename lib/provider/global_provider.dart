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

  void update(double cost) {
    _count = cost;
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

  void update(int time) {
    _totalTime = time;
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

  void update(int checking) {
    _check = checking;
  }
}

class ListProvider extends ChangeNotifier {
  List items = [0];

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

  List GetItems() {
    return items;
  }

  void Update(List list) {
    items = list;
    notifyListeners();
  }
}

class DynamicList {
  List _item = [];
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

class Lang extends ChangeNotifier {
  int lang = 0;

  toKor() {
    lang = 0;
    notifyListeners();
  }

  toEng() {
    lang = 1;
    notifyListeners();
  }
}

class ItemList {
  List<String> itemList = [
    'assets/null.png',
    'assets/item1.png',
    'assets/item2.png',
    'assets/item3.png',
    'assets/item4.png',
    'assets/item5.png',
    'assets/item6.png',
    'assets/item7.png',
    'assets/item8.png',
    'assets/item9.png',
    'assets/item10.png',
    'assets/item11.png',
    'assets/item12.png',
    'assets/item13.png',
    'assets/item14.png',
    'assets/item15.png',
    'assets/item16.png',
    'assets/item17.png',
  ];
}
