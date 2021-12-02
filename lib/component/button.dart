
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter/component/text.dart';

Widget button(Function ontap,String title){
  return  RaisedButton(
    onPressed:ontap,
    color: Colors.green,
    child:text(title, 15,color: Colors.white),
  );
}
Widget Loadbutton(){
  return  RaisedButton(
      onPressed:(){},
      color: Colors.green,
      child:CupertinoActivityIndicator()
  );
}