import 'package:flutter/cupertino.dart';

class DataClass extends ChangeNotifier {
  String _number = "";
  String get number => _number;

  int _userid = 0;
  int get userid => _userid;

  void changeNumber(String number) {
    _number = number;
    notifyListeners();
  }

  void changeUserId(int userid) {
    _userid = userid;
    notifyListeners();
  }
}
