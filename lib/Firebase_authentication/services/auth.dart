import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/Firebase_authentication/model/user.dart';


class AuthServices{
  final FirebaseAuth auth=FirebaseAuth.instance;

  //create user obj based on firebaseuser
  User_model? _userFromFirebaseUser(User user){
    return user!=null ? User_model(user.uid) : null;
  }

  //sign in anon
  Future signInAnon()async{
    try{
      UserCredential result= await auth.signInAnonymously();
      User? user=result.user;
      return _userFromFirebaseUser(user!);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

}