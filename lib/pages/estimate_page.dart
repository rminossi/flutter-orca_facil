import 'package:flutter/material.dart';
import 'package:ihc_g2/datas/estimate_data.dart';
import 'package:ihc_g2/models/estimate_model.dart';

class EstimatePage extends StatefulWidget {
  
  final Estimate estimate;

 EstimatePage(this.estimate);

  @override
  
  _EstimatePageState createState() => _EstimatePageState(estimate);
}

class _EstimatePageState extends State<EstimatePage> {

  final _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

final Estimate estimate;

  _EstimatePageState(this.estimate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${estimate.title}"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Text(
                  "${estimate.title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 24),
                SizedBox(
                  height: 44,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: (){
                    },
                    child: Text("Adicionar ao",
                      style: TextStyle(fontSize: 18)
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}