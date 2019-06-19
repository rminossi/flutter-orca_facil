import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ihc_g2/datas/product_data.dart';
import 'package:ihc_g2/tiles/product_tile.dart';

class CategoryPage extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryPage(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: Firestore.instance.collection("products").document(snapshot.documentID).collection("itens").getDocuments(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              }else{
                return TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ListView.builder(
                      padding: EdgeInsets.all(4),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                        data.category = this.snapshot.documentID;
                        return ProductTile("list", data);
                      },  
                    ),
                  ],
                );

              }
            }
          )
      ),
    );
  }
}