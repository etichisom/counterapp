import 'package:flutter/material.dart';

Widget field(TextEditingController controller,String s,{bool secure =false}){
  return TextFormField(
    obscureText: secure,
    controller: controller,
    decoration: InputDecoration(
        labelText: s
    ),
  );
}