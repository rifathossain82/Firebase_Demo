import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home_another extends StatefulWidget {
  const Home_another({Key? key}) : super(key: key);

  @override
  _Home_anotherState createState() => _Home_anotherState();
}

class _Home_anotherState extends State<Home_another> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final key = GlobalKey<FormState>();

  String errorText='';
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Logged ' + (user == null ? 'out' : 'in')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: key,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (email) {
                  if (email!.isEmpty || email == null) {
                    return 'Email address is required.';
                  }

                  String pattern = r'\w+@\w+\.\w+';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(email))
                    return 'Invalid E-mail Address format.';

                  return null;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                controller: passController,
                decoration: InputDecoration(
                    hintText: 'Passwrod', border: OutlineInputBorder()),
                validator: (pass) {
                  if (pass!.isEmpty || pass == null) {
                    return 'Password is required.';
                  }
                  else if (pass.length<8 && pass.length>16) {
                    return 'Password must be 8-16 characters';
                  }

      //             String pattern =
      //                 r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      //             RegExp regex = RegExp(pattern);
      //             if (!regex.hasMatch(pass))
      //               return '''
      // Password must be at least 8 characters,
      // include an uppercase letter, number and symbol.
      // ''';

                  else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 12,),
              Center(child: Text(errorText)),
              SizedBox(
                height: 32,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    try{
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passController.text);

                      emailController.clear();
                      passController.clear();
                      errorText='';
                    } on FirebaseAuthException
                    catch(error){
                      errorText=error.message!;
                    }
                  }
                },
                icon: Icon(Icons.lock_open),
                label: Text('Sign Up'),
              ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  emailController.clear();
                  passController.clear();
                  setState(() {});
                },
                icon: Icon(Icons.logout),
                label: Text('Logout'),
              ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50)),
                onPressed: () async {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passController.text);

                  emailController.clear();
                  passController.clear();
                  setState(() {});
                },
                icon: Icon(Icons.lock_open),
                label: Text('Sign In'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
