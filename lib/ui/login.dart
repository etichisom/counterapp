import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inter/bloc/pagebloc.dart';
import 'package:inter/component/appbar.dart';
import 'package:inter/component/button.dart';
import 'package:inter/component/input.dart';
import 'package:inter/component/text.dart';
import 'package:inter/ui/home.dart';
import 'package:inter/ui/register.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {

  @override
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  bool loading = false;
  Pagebloc pagebloc;
  @override
  Widget build(BuildContext context) {
    pagebloc = Provider.of<Pagebloc>(context);
    return Scaffold(
      appBar: appbar(context, 'Login'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              field(email, 'email'),
              SizedBox(
                height: 10,
              ),
              field(pass, 'Password', secure: true),
              SizedBox(
                height: 30,
              ),
              pagebloc.apicall
                  ? Loadbutton()
                  : button(() {
                if (email.text.length > 3 && pass.text.length > 3) {
                  reg(context);
                } else {
                  Fluttertoast.showToast(
                      msg: 'Password or email to short');
                }
              }, "Login"),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: text('Do not have an account? Sign up', 16)),
            ],
          ),
        ),
      ),
    );
  }
  void reg(BuildContext context) {
    pagebloc.setload(true);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email.text.trim(), password: pass.text.trim())
        .then((value) {
      pagebloc.setload(false);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    }).catchError((e) {
      pagebloc.setload(false);
      Fluttertoast.showToast(msg: e.toString());
    });
  }
}




