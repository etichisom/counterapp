import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inter/bloc/pagebloc.dart';
import 'package:inter/component/appbar.dart';
import 'package:inter/component/button.dart';
import 'package:inter/component/input.dart';
import 'package:inter/ui/home.dart';
import 'package:provider/provider.dart';
class Register extends StatelessWidget {
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  bool loading = false;
  Pagebloc pagebloc;
  @override
  Widget build(BuildContext context) {
    pagebloc = Provider.of<Pagebloc>(context);
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
              pagebloc.apicall?Loadbutton():button((){
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
    pagebloc.setload(true);
    FirebaseAuth.
    instance.
    createUserWithEmailAndPassword(email: email.text.trim(),
        password:pass.text.trim()).
    then((value){
      pagebloc.setload(false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));
    }).catchError((e){
      pagebloc.setload(false);
      Fluttertoast.showToast(msg:e.toString());
    });
  }
}



