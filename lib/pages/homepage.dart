import 'package:flutter/material.dart';
import 'package:ihc_g2/tabs/home_tab.dart';

class HomePage extends StatelessWidget {
  
final _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeTab()
      ],
    );
  }
}