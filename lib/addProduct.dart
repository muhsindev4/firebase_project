import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget{
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  XFile? _img;

  final TextEditingController _productName=TextEditingController();

  final TextEditingController _productPrice=TextEditingController();

  final TextEditingController _productDesc=TextEditingController();

  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  Future<void> createProduct(BuildContext context) async {

    if(_productName.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please enter your product name")));
    }else if(_productPrice.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please enter your product price")));
    }else if(_productDesc.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please enter your product Desc")));
    }else{
     String imgUrl= await uploadImage();

      _firestore.collection("products").add(
        {
          "productName":_productName.text,
          "productImage":imgUrl,
          "productPrice":_productPrice.text,
          "productDescription":_productDesc.text,
        }
      ).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Added")));
        Navigator.pop(context);
      });
    }
  }

 Future<String> uploadImage()async{
    FirebaseStorage storage=FirebaseStorage.instance;
    Reference reference=storage.ref('products/${_img!.name}.png');
    UploadTask task=reference.putFile(File(_img!.path));
    task.whenComplete(() {
      print("Uploaded");
    });
   return await reference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              if(_img==null)
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  ImagePicker picker=ImagePicker();
                  _img=await picker.pickImage(source: ImageSource.gallery);
                  setState(() {

                  });
                },
              )else
                Image.file(File(_img!.path),
                height: 100,width: 100,),


              //product name
              TextField(
                controller: _productName,
                decoration: InputDecoration(
                  hintText: "Product name",
                ),
              ),

              //product price
              TextField(
                controller: _productPrice,
                keyboardType:TextInputType.number ,
                decoration: InputDecoration(
                    hintText: "Product price"
                ),
              ),

              //product desc
              TextField(
                controller: _productDesc,
                decoration: InputDecoration(
                    hintText: "Product description"
                ),
              ),

              ElevatedButton(
                onPressed: (){
                  createProduct(context);
                },
                child: Text("Add Product"),
              )
            ],
          ),
        ),
      ),
    );
  }
}