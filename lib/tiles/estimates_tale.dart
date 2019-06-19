import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EstimatesTile extends StatelessWidget {

  final String estimateId;
  EstimatesTile(this.estimateId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("estimates").document(estimateId).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              return Column(
                children: <Widget>[
                  Text("Código do Pedido: ${snapshot.data.documentID}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _buildProductsText(snapshot.data)
                  ),
                ],
              );
            }
          },
        ),
      ),


    );
  }
  String _buildProductsText(DocumentSnapshot snapshot){
    String text = "Descrição:\n";
    for(LinkedHashMap p in snapshot.data["products"]){
      text += "${p["quantity"]} x ${p["product"]["title"]} ${p["product"]["type"]} de ${p["product"]["material"]} - ${p["product"]["width"]} x ${p["product"]["height"]} \n";
    }
    return text;
  }
}