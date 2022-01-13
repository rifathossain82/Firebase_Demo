import 'package:firebase_demo/firebase_storage/download/Image_page.dart';
import 'package:firebase_demo/firebase_storage/download/firebaseApi.dart';
import 'package:flutter/material.dart';

import 'firebaseFile.dart';

class Home_Download extends StatefulWidget {
  const Home_Download({Key? key}) : super(key: key);

  @override
  _Home_DownloadState createState() => _Home_DownloadState();
}

class _Home_DownloadState extends State<Home_Download> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFiles = FirebaseApi.listAll('files/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Download'),
        elevation: 0,
      ),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Some error occurred'),
                );
              } else {
                final files = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.blue,
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.file_copy,color: Colors.white,),
                          SizedBox(width: 12,),
                          Text('${files!.length} Files',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            return ListTile(
                            leading: ClipOval(child: Image.network(file.url,fit: BoxFit.cover,height: 52,width: 52,)),
                              title: Text(file.name,style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline,color: Colors.blue),),
                              onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Image_page(file: file)));
                              },
                            );
                          }),
                    )
                  ],
                );
              }
          }
        },
      ),
    );
  }
}
