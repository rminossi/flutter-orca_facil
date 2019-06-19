import 'package:flutter/material.dart';
import 'package:ihc_g2/models/estimate_model.dart';
import 'package:ihc_g2/models/user_model.dart';
import 'package:ihc_g2/pages/estimate_page.dart';
import 'package:ihc_g2/pages/homepage.dart';
import 'package:ihc_g2/pages/signup_page.dart';
import 'package:ihc_g2/tabs/estimates_tab.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<EstimateModel>(
            model: EstimateModel(model),
            child: MaterialApp(
            title: 'Orça Fácil',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Color.fromARGB(255, 4, 125, 141)
            ),
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          ),  
          );
        },
      ) 
    );
  }
}

