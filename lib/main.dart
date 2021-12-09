import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inter/bloc/counter.dart';
import 'package:inter/bloc/pagebloc.dart';
import 'package:inter/component/text.dart';
import 'package:inter/ui/home.dart';
import 'package:inter/ui/login.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Counterbloc()),
    ChangeNotifierProvider(create: (_) => Pagebloc()),
  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
 @override
  StatelessElement createElement() {
    // TODO: implement createElement
    return super.createElement();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Splash()
    );
  }
}
class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2),(){
      if(FirebaseAuth.instance.currentUser==null){
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>Login()));
      }else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>Home()));
      }
    });
    return Scaffold(
      body: Center(child: text('counter', 30)),
    );
  }
}

