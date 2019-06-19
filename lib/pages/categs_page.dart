import 'package:flutter/material.dart';
import 'package:ihc_g2/tabs/categ_tab.dart';
import 'package:ihc_g2/widgets/estimate_button.dart';

class CategsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categorias"),
          centerTitle: true,
          ),
          body: CategTab(),
          floatingActionButton: EstimateButton(),
      ),
    );
  }
}