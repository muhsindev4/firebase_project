import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget{
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final ImagePicker _imagePicker=ImagePicker();
  final FirebaseStorage _storage=FirebaseStorage.instance;
  List<XFile>? images=[];

  pickImage() async {
    images= await _imagePicker.pickMultiImage();

    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(
            child: images!.isEmpty? IconButton(
              onPressed: () async {

              },
              icon: Icon(Icons.add),
            ):
           SizedBox(
             height: 200,
             child: ListView.builder(
               scrollDirection: Axis.horizontal,
               itemCount: images!.length,
               itemBuilder: (BuildContext context, int index) {
                 return Image.file(File(images![index].path),height: 200,width: 200,);
               },
             ),
           )
          ),
        ],
      ),
    );
  }
}



// final Reference storageReference = FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
// final UploadTask uploadTask = storageReference.putFile(File(imagePath));
// await uploadTask.whenComplete(() {
// // Handle the completion of the upload.
// });