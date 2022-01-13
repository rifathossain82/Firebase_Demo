import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class Home_storage extends StatefulWidget {
  const Home_storage({Key? key}) : super(key: key);

  @override
  _Home_storageState createState() => _Home_storageState();
}

class _Home_storageState extends State<Home_storage> {
  File? file;
  UploadTask? task;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Storage Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: ()async{
                  final result=await FilePicker.platform.pickFiles(allowMultiple: false);

                  if(result==null){
                    return;
                  }
                  else{
                    final path=result.files.single.path;
                    setState(() {
                      file=File(path!);
                    });
                  }
                },
                icon: Icon(Icons.attach_file),
                label: Text('Select File'),

            ),
            SizedBox(height: 8,),
            file==null?Text('No File Selected'):Text(basename(file!.path)),
            SizedBox(height: 8,),
            ElevatedButton.icon(
              onPressed: ()async{
                if(file==null){
                  return;
                }
                else{
                  final fileName=basename(file!.path);
                  final destination='files/$fileName';
                  task=FirebaseApi.uploadTask(destination, file!);
                  setState(() {

                  });

                  if(task==null){
                    return;
                  }
                  else{
                    final snapshot=await task!.whenComplete((){
                      setState(() {

                      });
                    });
                    final urlDownload=await snapshot.ref.getDownloadURL();

                    print('Download link: $urlDownload');
                  }
                }
              },
              icon: Icon(Icons.upload_file),
              label: Text('Upload File'),

            ),
            SizedBox(height: 20,),
            task!=null? buildUploadStatus(task!):Container(),
          ],
        ),
      ),
    );
  }

  //to show progress
  Widget buildUploadStatus(UploadTask task){
    return StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
        builder:(context,snapshot){
        final snap=snapshot.data;
        final progress=snap!.bytesTransferred/snap.totalBytes;
        final percentage=(progress*100).toStringAsFixed(2);

        return Text('$percentage %',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
        }
    );
  }
}


class FirebaseApi{

  //to upload file
  static UploadTask? uploadTask(String destination, File file){
    try{
      final ref=FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    }
    catch(e){
      return null;
    }
  }


  //to upload bytes data
  static UploadTask? uploadBytes(String destination, Uint8List data){
    try{
      final ref=FirebaseStorage.instance.ref(destination);
      return ref.putData(data);
    }
    catch(e){
      return null;
    }
  }
}