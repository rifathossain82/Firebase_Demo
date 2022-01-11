import 'package:firebase_database/firebase_database.dart';
import 'message.dart';

class Message_dao{
  final DatabaseReference message_ref=FirebaseDatabase.instance.reference().child('message');


  void saveMessage(Message message){
    message_ref.push().set(message.toJson());
  }

  Query getMessageQuery(){
    return message_ref;
  }
}