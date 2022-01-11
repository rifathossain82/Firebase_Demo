import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/Firebase_authentication/services/auth.dart';
import 'package:flutter/material.dart';

class SingIn_page extends StatefulWidget {
  const SingIn_page({Key? key}) : super(key: key);

  @override
  _SingIn_pageState createState() => _SingIn_pageState();
}

class _SingIn_pageState extends State<SingIn_page> {

  final AuthServices services=AuthServices();

  TextEditingController emailController=TextEditingController();
  TextEditingController passController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: passController,
              decoration: InputDecoration(
                  hintText: 'Passwrod',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 32,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 50)
              ),
              onPressed: (){
                dynamic result=services.signInAnon();
                if(result!=null){
                  print('signed in');
                  print(result);
                }
                else{
                  print('error signed in');
                }
              },
              icon: Icon(Icons.lock_open),
              label: Text('Sign In'),
            )
          ],
        ),
      ),
    );
  }



}
