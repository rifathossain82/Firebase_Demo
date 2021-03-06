import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/Firebase_auth_another/Home_another.dart';
import 'package:firebase_demo/Firebase_authentication/Wrapper.dart';
import 'package:firebase_demo/facebook_signIn/Home_facebookSignIn.dart';
import 'package:firebase_demo/firebase_storage/download/Home_Download.dart';
import 'package:firebase_demo/firebase_storage/upload/Home_storage.dart';
import 'package:firebase_demo/firestore_demo/Home_firestore.dart';
import 'package:firebase_demo/google_sign_in/Home_googleSignIn.dart';
import 'package:firebase_demo/phone_authentication/login.dart';
import 'package:flutter/material.dart';

import 'RealTime_Database_elt_class/pages/Homepage_way1.dart';

 void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home_Download(),
    );
  }
}


/*
StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Home_auth();
          }
          else{
            return LoginPage();
          }
        },
      ),
 */

