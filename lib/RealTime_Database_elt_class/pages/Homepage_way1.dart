import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../data/message.dart';
import '../data/message_dao.dart';
import '../widget/message_widget.dart';

class Homepage_way1 extends StatefulWidget {
  const Homepage_way1({Key? key}) : super(key: key);

  @override
  _Homepage_way1State createState() => _Homepage_way1State();
}

Message_dao message_dao=Message_dao();

class _Homepage_way1State extends State<Homepage_way1> {

  TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo'),
      ),
      body: Center(
        child: Column(
          children: [
            getMessageList(),
            Row(
              children: [
                Flexible(child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter data'
                    ),
                  ),
                )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: (){
                        createRecord();
                      },
                      child: Icon(Icons.add)
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget getMessageList(){
    return Expanded(child: FirebaseAnimatedList(
      query: message_dao.getMessageQuery(),
      itemBuilder: (context,snapshot,animation,index){
        final json=snapshot.value as Map<dynamic,dynamic>;
        final message=Message.fromJson(json);
        return Message_widget(text: message.text, date: message.date);
      },
    ));
  }


  void createRecord(){
    final message=Message(controller.text, DateTime.now());
    message_dao.saveMessage(message);
    controller.clear();
  }
}
