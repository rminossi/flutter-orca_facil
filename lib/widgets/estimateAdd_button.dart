import 'package:flutter/material.dart';
import 'package:ihc_g2/pages/estimate_page.dart';
import 'package:ihc_g2/pages/newEstimate_page.dart';


class EstimateAddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.white,),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>NewEstimatePage())
        );
      },
      backgroundColor: Colors.black,
    );
  }
}