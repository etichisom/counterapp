import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inter/component/appbar.dart';
import 'package:inter/component/button.dart';
import 'package:inter/component/input.dart';
import 'package:inter/ui/home.dart';

class Register extends StatefulWidget {


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  bool loading = false;
 void stop(){setState(() {loading=false;});}
  void start(){setState(() {loading=true;});}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Register'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              field(email, 'email'),
              SizedBox(height: 10,),
              field(pass, 'Password',secure: true),
              SizedBox(height: 30,),
              loading?Loadbutton():button((){
                if(email.text.length>3&&pass.text.length>3){
                  reg(context);
                }else{
                  Fluttertoast.showToast(msg: 'Password or email to short');
                }

              },"Create account")
            ],
          ),
        ),
      ),
    );
  }

  void reg(BuildContext context) {
   start();
    FirebaseAuth.
    instance.
    createUserWithEmailAndPassword(email: email.text.trim(),
        password:pass.text.trim()).
    then((value){
      stop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));
    }).catchError((e){
      stop();
      Fluttertoast.showToast(msg:e.toString());
    });
  }
}
