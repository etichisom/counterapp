import 'package:flutter/cupertino.dart';

class Pagebloc extends ChangeNotifier{
  bool apicall = false;
  setload(bool s){
    apicall=s;
    notifyListeners();
  }
}