import 'package:firebase_demo/firebase_storage/download/firebaseApi.dart';
import 'package:firebase_demo/firebase_storage/download/firebaseFile.dart';
import 'package:flutter/material.dart';

class Image_page extends StatefulWidget {
  FirebaseFile file;
  Image_page({Key? key,required this.file}) : super(key: key);

  @override
  _Image_pageState createState() => _Image_pageState();
}

class _Image_pageState extends State<Image_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.file.name),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: ()async{
                await FirebaseApi.downloadFile(widget.file.reference);

                final snackBar=SnackBar(
                    content: Text('Download ${widget.file.name}'),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: Icon(Icons.file_download),
          )
        ],
      ),
      body: Image.network(
        widget.file.url,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
