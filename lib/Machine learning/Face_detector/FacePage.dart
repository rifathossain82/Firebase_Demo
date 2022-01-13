
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FacePage extends StatefulWidget {
  const FacePage({Key? key}) : super(key: key);

  @override
  _FacePageState createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {

  late File _imageFile;
  late List<Face> _faces;

  //
  // void getImageDetectFaces()async{
  //   final imageFile=await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  //   final image=FirebaseVisionImage.fromFile(File(imageFile!.path));
  //
  //   final faceDetector=FirebaseVision.instance.faceDetector(
  //     FaceDetectorOptions(
  //       mode: FaceDetectorMode.accurate,
  //       enableLandmarks: true
  //     )
  //   );
  //
  //   final faces=await faceDetector.processImage(image);
  //   if(mounted){
  //     setState(() {
  //       _imageFile=File(imageFile.path);
  //       _faces=faces.cast<Face>();
  //     });
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detector'),
      ),
      body: ImageAndFaces(imageFile: _imageFile, faces: _faces,),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        tooltip: 'Add a photo',
        onPressed: (){

        },
      ),
    );
  }
}


class Face{
  late final Rectangle<int> boundingBox;
  late final double headEulerAngleY;
  late final double headEulerAngleZ;
  late final double leftEyeOpenProbability;
  late final double rightEyeOpenProbabilility;
  late final double smilingProbability;
  late final int trackingId;
  // FaceLandmark getLandmark(
  //     FaceLandmarkType landmark,
  //     )=> getLandmark(landmark);
}


class ImageAndFaces extends StatelessWidget {
  final File imageFile;
  final List<Face> faces;

  ImageAndFaces({Key? key,required this.imageFile,required this.faces}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
            child: Container(
              constraints: BoxConstraints.expand(),
                child: Image.file(
                  imageFile,fit: BoxFit.cover,
                )
            )
        ),
        Flexible(
            flex: 1,
            child: ListView(
              children: faces.map<Widget>((f) => FaceCordinates(face: f,)).toList(),
            )
        ),
      ],
    );
  }
}

class FaceCordinates extends StatelessWidget {
  final Face face;
  FaceCordinates({Key? key,required this.face}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pos=face.boundingBox;
    return ListTile(
      title: Text('(${pos.top}),(${pos.left}),(${pos.bottom},(${pos.right}))'),
    );
  }
}

