import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inter/bloc/counter.dart';
import 'package:inter/ui/login.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final ref = FirebaseDatabase.instance.reference();
  Counterbloc counterbloc;
  var user =  FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    counterbloc = Provider.of<Counterbloc>(context);
    Future.delayed(Duration(seconds: 1,),(){
      ref.child(user.uid).onValue.listen((event) {
        if(event.snapshot.exists){
          counterbloc.setnum(event.snapshot.value);
        }else{
          counterbloc.setnum(0);
        }
      });
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: (){
                  FirebaseAuth.instance.signOut();

                  Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Login()));

                },
                child: Icon(Icons.logout)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        add();
      },
        child: Icon(Icons.add,color: Colors.white,),),
      body:Center(child: counterbloc.push==null?CircularProgressIndicator():
      Text(user.email+" You have pushed : "+counterbloc.push.toString())),
    );
  }
  void add() {
   if(counterbloc.push!=null){
     ref.child(user.uid).set(counterbloc.push+1).catchError((e){
       print(e.toString());
     }).then((value) => print('updated'));
   }

  }
}
