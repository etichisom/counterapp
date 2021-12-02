import 'package:flutter/cupertino.dart';

class Counterbloc extends ChangeNotifier{
  int push;
  setnum(int i){
    push=i;
    notifyListeners();
  }
}
