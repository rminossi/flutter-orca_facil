import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ihc_g2/datas/estimate_data.dart';
import 'package:ihc_g2/datas/product_data.dart';
import 'package:ihc_g2/models/estimate_model.dart';

class EstimateTile extends StatelessWidget {
  
  final Estimate estimate;

  EstimateTile(this.estimate);
  
  @override
  Widget build(BuildContext context) {

    Widget _buildContent(){
      return Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            width: 120,
            child: Image.network(
              estimate.productData.image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: 16,),
                  Text(
                    "${estimate.productData.title} - ${estimate.productData.material}",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    estimate.productData.type,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Theme.of(context).primaryColor,
                        onPressed: estimate.quantity > 1 ? (){
                          EstimateModel.of(context).decProduct(estimate);
                        } : null,
                      ),
                      Text(estimate.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          EstimateModel.of(context).incProduct(estimate);
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      FlatButton(
                          child: Text("Remover"),
                          textColor: Colors.grey[500],
                          onPressed: (){
                            EstimateModel.of(context).removeEstimateItem(estimate);
                          },
                        ),
                    ],
                  )
                  

                ],
              ),
            ),
          )
        ],
      );
    }
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: estimate.productData == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance
            .collection("products")
            .document(estimate.category)
            .collection("itens")
            .document(estimate.pid).get(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              estimate.productData = ProductData.fromDocument(snapshot.data);
              return _buildContent();
            }else {
              return Container(
                height: 70,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          },        
        ):
        _buildContent()
    );
  }
}