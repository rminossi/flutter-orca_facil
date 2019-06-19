import 'package:flutter/material.dart';
import 'package:ihc_g2/models/estimate_model.dart';

class EstimateInfos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Informações do orçamento")
                  ],
                ),
                SizedBox(height: 12,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Título"
                  ), 
                  initialValue: EstimateModel.of(context).title ?? "",
                ),
                SizedBox(height:12),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Observações"
                  ),
                  initialValue: EstimateModel.of(context).description ?? "",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}