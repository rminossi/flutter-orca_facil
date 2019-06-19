import 'package:flutter/material.dart';
import 'package:ihc_g2/pages/login_page.dart';
import 'package:ihc_g2/tabs/categ_tab.dart';
import 'package:ihc_g2/tabs/estimates_tab.dart';
import 'package:ihc_g2/tabs/home_tab.dart';
import 'package:ihc_g2/widgets/custom_drawer.dart';
import 'package:ihc_g2/widgets/estimateAdd_button.dart';
import 'package:ihc_g2/widgets/estimate_button.dart';

class HomePage extends StatelessWidget {
  
final _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Orçamentos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: EstimatesTab(),
          floatingActionButton: EstimateAddButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CategTab(),
        ),
        Scaffold(
          body: LoginPage(),
          drawer: CustomDrawer(_pageController),
        ),
        
      ],
    );
  }
}