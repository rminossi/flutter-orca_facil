import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData{
  
  String category;
  String id;
  String title;
  String type;
  String image;
  String material;
  double height;
  double width;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data["title"];
    type = snapshot.data["type"];
    material = snapshot.data["material"];
    image = snapshot.data["image"];
    height = snapshot.data["height"] + 0.0;
    width = snapshot.data["width"] + 0.0;
  }

  Map<String, dynamic> toResumedMap(){
    return{
      "title": title,
      "type": type,
      "material": material,
      "height": height,
      "width": width,
    };
  }

}