import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFile{
  final Reference reference;
  final String name;
  final String url;

  FirebaseFile(this.reference, this.name, this.url);
}