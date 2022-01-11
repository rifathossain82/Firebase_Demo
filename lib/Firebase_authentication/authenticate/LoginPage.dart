import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
              onPressed: sign_in,
              icon: Icon(Icons.lock_open),
              label: Text('Sign In'),
            )
          ],
        ),
      ),
    );
  }


  Future sign_in()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passController.text.trim()
    );
  }
}
