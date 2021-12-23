import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SortIndexProvider with ChangeNotifier {
  int _selPos = 0;

  int get selPos => _selPos;

  void setSelPos(int pos) {
    _selPos = pos;
    notifyListeners();
  }
}
