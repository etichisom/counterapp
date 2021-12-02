import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget text(String text,double size,{Color color=Colors.black,bool isbold=false}){
  return Text(text,style: GoogleFonts.roboto(fontSize: size
      ,color: color,fontWeight: isbold?FontWeight.bold:FontWeight.normal),);
}