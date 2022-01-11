import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';

class Message_widget extends StatefulWidget {
  String text;
  DateTime date;

  Message_widget({Key? key, required this.text, required this.date})
      : super(key: key);

  @override
  _Message_widgetState createState() => _Message_widgetState();
}

class _Message_widgetState extends State<Message_widget> {
  final firebaseDatabase = FirebaseDatabase.instance.reference();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FocusedMenuHolder(
        onPressed: () {},
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(widget.text)),
                        Text(DateFormat('yyy-MM-dd, hh:mma')
                            .format(widget.date)
                            .toString()),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        menuItems: [
          FocusedMenuItem(
            title: Text('Edit'),
            onPressed: () {
              firebaseDatabase
                  .child('message')
                  .orderByChild('text')
                  .equalTo(widget.text)
                  .once()
                  .then((value) {
                Map data = value.value;
                var key = data.keys.toString();
                controller.text = widget.text;

               showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text('Change Text'),
                        content: Column(
                          children: [
                            TextField(
                              controller: controller,
                              decoration:
                                  InputDecoration(labelText: 'Write Text'),
                            )
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: () {
                                firebaseDatabase
                                    .child("message")
                                    .child(key.substring(1, key.length - 1))
                                    .update({'text': controller.text}).then(
                                        (value) {
                                  print('Success');
                                }).catchError((onError) {
                                  print('Error');
                                });
                              },
                              child: Text('Save'))
                        ],
                      );
                    });
              });
            },
            trailingIcon: Icon(Icons.edit),
            backgroundColor: Colors.green,
          ),
          FocusedMenuItem(
            title: Text('Delete'),
            onPressed: () {
              firebaseDatabase
                  .child('message')
                  .orderByChild('text')
                  .equalTo(widget.text)
                  .once()
                  .then((value) {
                Map data = value.value;
                var key = data.keys.toString();

                firebaseDatabase
                    .child('message')
                    .child(key.substring(1, key.length - 1))
                    .remove();
              });
            },
            trailingIcon: Icon(Icons.delete),
            backgroundColor: Colors.redAccent,
          )
        ]);
  }
}
