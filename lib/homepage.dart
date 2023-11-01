import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xox/addProduct.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore _db=FirebaseFirestore.instance;

  List<QueryDocumentSnapshot> products=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddProduct()));
        },
      ),
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: StreamBuilder(
        stream: _db.collection("products").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          products=snapshot.data!.docs;
          return ListView.separated(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Image.network(products[index].get("productImage"),
                    height: 100,width: 100,),

                  Text(products[index].get("productName")),

                  Text(products[index].get("productPrice")),

                  Text(products[index].get("productDescription")),

                  IconButton(
                    onPressed: (){
                      _db.collection("products").doc(snapshot.data!.docs[index].id).delete();
                    },
                    icon: Icon(Icons.delete),
                  )
                ],
              );
            }, separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
          );
        },
      ),

    );
  }
}