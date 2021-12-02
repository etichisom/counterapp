import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


Widget appbar(BuildContext context,String s){
  return AppBar(
    elevation:0,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: false,
    backgroundColor: Colors.transparent,
    title: Text(s,style: GoogleFonts.roboto(color: Colors.black),),
  );
}