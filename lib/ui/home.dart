import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inter/bloc/counter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ref = FirebaseDatabase.instance.reference();
   Counterbloc counterbloc;
   var user =  FirebaseAuth.instance.currentUser;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200,),(){
      ref.child(user.uid).onValue.listen((event) {
        if(event.snapshot.exists){
          counterbloc.setnum(event.snapshot.value);
        }else{
          counterbloc.setnum(0);
        }
        print(event.snapshot.value.toString() +'me');
      });
    });

  }
  @override
  Widget build(BuildContext context) {
   counterbloc = Provider.of<Counterbloc>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                FirebaseAuth.instance.signOut()
                    .then((value){
                 // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));
                });
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