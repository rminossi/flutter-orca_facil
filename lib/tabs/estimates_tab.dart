import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ihc_g2/models/user_model.dart';
import 'package:ihc_g2/tiles/estimates_tale.dart';
import 'package:path/path.dart';

class EstimatesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
  if(UserModel.of(context).isLoggedIn()){
    
      String uid = UserModel.of(context).firebaseUser.uid;  

    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("users").document(uid).collection("estimates").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          return ListView(
            children: snapshot.data.documents.map((doc) => EstimatesTile(doc.documentID)).toList(),
          );
        }
      }      
    );
  } else {

     return Center(
            child: CircularProgressIndicator(),
          );

    }
  }
}