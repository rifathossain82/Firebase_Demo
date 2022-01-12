import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/material.dart';

class Facebook_signIn extends StatefulWidget {
  const Facebook_signIn({Key? key}) : super(key: key);

  @override
  _Facebook_signInState createState() => _Facebook_signInState();
}

class _Facebook_signInState extends State<Facebook_signIn> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  Map _userData = {};
  bool isloggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Sign In'),
      ),
      body: Container(
        child: isloggedIn
            ? Column(
                children: [
                  Image.network(_userData['picture']['data']['url']),
                  Text(_userData['name']),
                  Text(_userData['email']),
                  ElevatedButton(
                      onPressed: () {
                        FacebookAuth.instance.logOut().then((value) {
                          setState(() {
                            isloggedIn = false;
                            _userData = {};
                          });
                        });
                      },
                      child: Text('Logout'))
                ],
              )
            : Center(
                child: ElevatedButton(
                    //if user already sign in then this button is disabled
                    onPressed: () async {
                      FacebookAuth.instance.login(
                        permissions: ["public_profile","email"]
                      ).then((value){
                        FacebookAuth.instance.getUserData().then((userdata){
                          setState(() {
                            isloggedIn=true;
                            _userData=userdata;
                            print(_userData);
                          });
                        });
                      });
                    },
                    child: Text('Sign in')),
              ),
      ),
    );
  }
}

/*
final result = await FacebookAuth.i.login(
                        permissions: ["public_profile", "email"]
                    );
                    if(result.status==LoginStatus.success){
                      final requestData=await FacebookAuth.i.getUserData(
                          fields: "email, name"
                      );
                      setState(() {
                        user=requestData;
                        print('User Data: $user');
                      });
                    }
                    else if(result.status==LoginStatus.failed){
                      print('Login Failed');
                    }
                    else if(result.status==LoginStatus.cancelled){
                      print('Login cancelled');
                    }
                    else{
                      print('something wrong');
                    }
 */

/*
//another method
final _instance = FacebookAuth.instance;
                    final result = await _instance.login(permissions: ['email']);
                    if (result.status == LoginStatus.success) {
                      final OAuthCredential credential =
                      FacebookAuthProvider.credential(result.accessToken!.token);
                      final a = await _auth.signInWithCredential(credential);
                      await _instance.getUserData().then((userData) async {
                        await _auth.currentUser!.updateEmail(userData['email']);
                      });
                      print('login success');
                    } else if (result.status == LoginStatus.cancelled) {
                      print('Login cancelled');
                    } else {
                      print('Login error');
                    }
 */


/*
//
                      final LoginResult result = await FacebookAuth.instance
                          .login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
                      if (result.status == LoginStatus.success) {
                        // you are logged
                        final AccessToken accessToken = result.accessToken!;
                      } else {
                        print(result.status);
                        print(result.message);
                      }
 */