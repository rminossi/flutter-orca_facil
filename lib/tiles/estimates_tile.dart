import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ihc_g2/datas/estimate_data.dart';
import 'package:ihc_g2/models/estimate_model.dart';
import 'package:ihc_g2/pages/estimate_page.dart';

class EstimatesTile extends StatelessWidget {

  final String estimateId;
  EstimatesTile(this.estimateId);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>EstimatePage(Estimate())) 
        );
      },
      child: Card(
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
                int status = snapshot.data["status"];
                String title = snapshot.data["title"];
                String description = snapshot.data["description"];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${title}".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text("Código do Pedido: ${snapshot.data.documentID}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _buildProductsText(snapshot.data)
                    ),
                    SizedBox(height: 0),
                    Text(
                      "Descrição: ${description}"
                    ),
                    SizedBox(height: 6),
                    Divider(),
                    Text(
                      _buildProductsStatus(status),
                      style: TextStyle(
                        color: _buildProductsStatusColor(status)
                      ),
                    )
                  ],
                );
              }
            },
          ),
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

  String _buildProductsStatus(int status){
    String text = "Status: ";
        
      if(status == 1){
        text += "Aguardando resposta";
      } else if(status == 2){
        text += "Respondido";
      } else if(status == 3){
        text += "Finalizado";
      } else{
        text += "Cancelado";
      }
      
    return text;
  }

  Color _buildProductsStatusColor(int status){
    Color color; 
        
      if(status == 1){
        color = Colors.blueGrey;
      } else if(status == 2){
        color = Colors.yellowAccent;
      } else if(status == 3){
        color = Colors.greenAccent;
      } else{
        color = Colors.redAccent;        
      }
      
    return color;
  
  }
}