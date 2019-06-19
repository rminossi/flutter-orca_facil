import 'package:flutter/material.dart';
import 'package:ihc_g2/models/estimate_model.dart';
import 'package:ihc_g2/widgets/estimate_button.dart';
import 'package:scoped_model/scoped_model.dart';

class EstimatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orçamento"),
        centerTitle: true,
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<EstimateModel>(
              builder: (context, child, model){
                int p = model.products.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "Item" : "Itens"}"
                );
              },
            ),
          )
        ],
      ),
      body: Scaffold(
        floatingActionButton: EstimateButton(),
      ),
    );
  }
}