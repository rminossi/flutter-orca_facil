import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ihc_g2/models/user_model.dart';
import 'package:ihc_g2/pages/login_page.dart';
import 'package:ihc_g2/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

 CustomDrawer(this.pageController); 

  @override
  Widget build(BuildContext context) {

    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(30, 76, 158, 101),
            Color.fromARGB(90, 27, 192, 98)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
    );

    return SizedBox(
      width: 220.0,
      child: Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(children: <Widget>[
                  Positioned(
                    top: 8.0,
                    left: 0.0,
                    child: Text("Orça Fácil",
                      style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    left: 0.0,
                    bottom: 0.0,
                    child: ScopedModelDescendant<UserModel>(
                      builder: (context, child, model){
                        return  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Olá, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          child: Text(
                            "Sair",
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                          ),
                          onTap: (){
                            model.signOut();
                            Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context)=>LoginPage())
                            );
                          },
                        )
                      ],
                    );
                      },
                    )
                  )
                ],
                ),
              ),
            Divider(),
            DrawerTile(Icons.attach_money, "Orçamentos", pageController, 0),
            DrawerTile(Icons.store, "Lojas", pageController, 1),
            DrawerTile(Icons.account_circle, "Perfil", pageController, 2),
            ],
          )
        ],
      ),
    ),
    );
  }
}