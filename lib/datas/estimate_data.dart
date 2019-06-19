import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:ihc_g2/datas/product_data.dart';

class Estimate{
  
  String eid;
  String title;
  String description;
  String category;
  String pid;
  int quantity;
  

  ProductData productData;

  Estimate();

  Estimate.fromDocument(DocumentSnapshot document){
    eid = document.documentID;
    title = document.data["title"];
    description = document.data["description"];
    category = document.data["category"];
    quantity = document.data["quantity"];
    pid = document.data["pid"]; 
  }

  Map<String, dynamic> toMap(){
    return {
      "title": title,
      "pid": pid,
      "quantity": quantity,
      "description": description,
      "category": category,
      "product": productData.toResumedMap(),
    };
  }
}