import 'package:flutter/material.dart';
import 'package:ihc_g2/models/estimate_model.dart';
import 'package:ihc_g2/models/user_model.dart';
import 'package:ihc_g2/pages/homepage.dart';
import 'package:ihc_g2/tiles/estimate_tile.dart';
import 'package:ihc_g2/widgets/estimate_button.dart';
import 'package:ihc_g2/widgets/estimate_infos.dart';
import 'package:scoped_model/scoped_model.dart';

import 'categs_page.dart';

class NewEstimatePage extends StatefulWidget {
  @override
  _NewEstimatePageState createState() => _NewEstimatePageState();
}

class _NewEstimatePageState extends State<NewEstimatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Novo Orçamento"),
          centerTitle: true,
          ),
          body: ScopedModelDescendant<EstimateModel>(
            builder: (context, child, model){
              if(model.isLoading){
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (model.products == null || model.products.length == 0){
            return ListView(
              children: <Widget>[
              Container(
                padding: EdgeInsets.all(24),
               child: Column(
                 children: <Widget>[
                   SizedBox(height: 150.0,),
                   Text("Nenhum item adicionado!",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
                SizedBox(height: 150.0,),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.black,
                        child: Text("Adiicionar Itens"),
                        textColor: Colors.white,
                        disabledColor: Colors.yellow,
                        onPressed:(){
                          Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>CategsPage())
                          );                            
                        },
                      ),
                    ),
                 ],
               )
                    )
              ]                
            );
              }else{
                return ListView(
                  padding: EdgeInsets.all(24.0),
                  children: <Widget>[
                    Container(
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),

                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("Itens do orçamento")
                          ],
                        ),
                      ],
                    ),    
                    ),           
                     
                    Column(
                      children: model.products.map(
                        (product){
                          return EstimateTile(product);
                        }
                      ).toList(),
                    ),
                    EstimateInfos(),
                    SizedBox(height: 12),
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.black,
                          child: Text("Adiocionar Itens"),
                          textColor: Colors.white,
                          disabledColor: Colors.yellow,
                          onPressed:(){
                            Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>CategsPage())
                          );
                          },
                        ),
                    ),
                    SizedBox(height: 12),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.black,
                          child: Text("Enviar orçamento"),
                          textColor: Colors.white,
                          disabledColor: Colors.yellow,
                          onPressed:() async{
                            String estimateId = await model.saveEstimate();
                            if(estimateId != null){
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context)=>HomePage())
                              );
                            }
                          },
                        ),
                      ),
                  ],
                );
              }
            }
          ),
      );
  }  
}