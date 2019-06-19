import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ihc_g2/models/user_model.dart';
import 'package:ihc_g2/tiles/estimates_tile.dart';
import 'package:path/path.dart';

class HomeTab extends StatelessWidget {
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
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:16, right: 16, left: 16),
                child: Padding(
                  padding: EdgeInsets.only(top:16, right: 16, left: 16),
                  child: Text("Bem-vindo(a), ${UserModel.of(context).userData["name"]}",
                style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
                ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Você possui ${UserModel.of(context).userData["estimates"]}",
                style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
                ),
                ),
              ) 
            ]
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