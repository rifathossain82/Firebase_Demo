import 'package:flutter/material.dart';

class Home_auth extends StatefulWidget {
  const Home_auth({Key? key}) : super(key: key);

  @override
  _Home_authState createState() => _Home_authState();
}

class _Home_authState extends State<Home_auth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: Center(),
    );
  }
}
