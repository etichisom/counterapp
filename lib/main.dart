import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inter/bloc/counter.dart';
import 'package:inter/ui/home.dart';
import 'package:inter/ui/login.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Counterbloc()),
  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User>(
        stream:FirebaseAuth.instance.userChanges() ,
        builder: (context, snapshot) {
          if(snapshot.data==null){
            return Login();
          }
          return Home();
        }
      ) ,
    );
  }
}
