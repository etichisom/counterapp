import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inter/component/appbar.dart';
import 'package:inter/component/button.dart';
import 'package:inter/component/input.dart';
import 'package:inter/component/text.dart';
import 'package:inter/ui/home.dart';
import 'package:inter/ui/register.dart';

class Login extends StatefulWidget {


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Login> {
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
          padding: const EdgeInsets.all(20.0),
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

              },"Create account"),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));
                },
                  child: text('Do not have an account? Sign up', 16)),
            ],
          ),
        ),
      ),
    );
  }

  void reg(BuildContext context) {
    start();
    FirebaseAuth.
    instance.signInWithEmailAndPassword(email: email.text.trim(),
        password:pass.text.trim()).
    then((value){
      stop();
      Navigator.push(context,MaterialPageRoute(builder:(context)=>Home()));
    }).catchError((e){
      stop();
      Fluttertoast.showToast(msg:e.toString());
    });
  }
}
