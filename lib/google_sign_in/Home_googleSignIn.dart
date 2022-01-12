import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Home_googleSignIn extends StatefulWidget {
  const Home_googleSignIn({Key? key}) : super(key: key);

  @override
  _Home_googleSignInState createState() => _Home_googleSignInState();
}

GoogleSignIn googleSignIn=GoogleSignIn(scopes: ['email']);

class _Home_googleSignInState extends State<Home_googleSignIn> {
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user=googleSignIn.currentUser;    //to check current user status
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign In (Signed '+(user==null?'out':'in')+')'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              //if user already sign in then this button is disabled
                onPressed: user!=null? null:()async{//
                  await googleSignIn.signIn();
                  setState(() {

                  });
                },
                child: Text('Sign in')
            ),
            SizedBox(height: 12,),
            ElevatedButton(
              //if user is not sign in then this button is disabled
                onPressed: user==null? null:()async{ //
                  await googleSignIn.signOut();

                  setState(() {

                  });
                },
                child: Text('Sign out')
            ),
          ],
        ),
      ),
    );
  }
}
