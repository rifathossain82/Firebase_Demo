import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home_firestore extends StatefulWidget {
  const Home_firestore({Key? key}) : super(key: key);

  @override
  _Home_firestoreState createState() => _Home_firestoreState();
}

class _Home_firestoreState extends State<Home_firestore> {
  TextEditingController controller = TextEditingController();
  var id;

  @override
  Widget build(BuildContext context) {
    CollectionReference groceries =
        FirebaseFirestore.instance.collection('groceries');

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(12),
          child: TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            controller: controller,
            decoration: InputDecoration(
              labelText: controller.text,
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder(
            stream: groceries.orderBy('name').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                  children: snapshot.data!.docs.map((grocery) {
                return Center(
                  child: ListTile(
                    title: Text(grocery['name']),
                    onLongPress: () {
                      grocery.reference.delete();
                      controller.clear();
                      controller.text='';
                    },
                    onTap: (){
                      setState(() {
                        controller.text=grocery['name'];
                        id=grocery;

                      });
                    },
                  ),
                );
              }).toList());
            }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.edit),
            onPressed: () {
              id.reference.update(
                  {
                    'name': controller.text.toString(),
                  }).whenComplete((){
                print('update');
              });
              controller.clear();
              controller.text='';
            },
          ),
          SizedBox(height: 8,),
          FloatingActionButton(
            child: Icon(Icons.save),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                groceries.add({
                  'name': controller.text,
                });
              }
              controller.clear();
              controller.text='';
            },
          ),
        ],
      ),
    );
  }
}
