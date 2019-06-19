import 'package:flutter/material.dart';
import 'package:ihc_g2/models/user_model.dart';
import 'package:ihc_g2/pages/signup_page.dart';
import 'package:ihc_g2/widgets/input_field.dart';
import 'package:scoped_model/scoped_model.dart';

import 'homepage.dart';
 
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'E-mail inválido';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.greenAccent,
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return Form(
            key: _formKey,
            child: ListView(
            children: <Widget>[
              Container(),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/orcafacil-45f2d.appspot.com/o/logo.png?alt=media&token=e018e302-39be-411a-9bb7-9266c6b701f2", 
                      ), 
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person_pin, color: Colors.black),
                          hintText: "E-mail",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 5,
                            right: 30,
                            bottom: 30,
                            top: 30,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                        validator: validateEmail,                    
                      ),
                      TextFormField(
                        controller: _passController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock_outline, color: Colors.black),
                          hintText: "Senha",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 5,
                            right: 30,
                            bottom: 30,
                            top: 30,
                          ),
                        ),
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        validator: (text){
                          if(text.length <= 8) return "A senha deve conter no mínimo 8 caracteres";
                        },
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.black,
                          child: Text("Entrar"),
                          textColor: Colors.white,
                          disabledColor: Colors.yellow,
                          onPressed:(){
                            if(_formKey.currentState.validate()){
                              
                            }
                            model.signIn(
                              email: _emailController.text,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context)=>SignUpPage())
                            );
                          },
                          child: Text("Cadastre-se"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          onPressed: (){
                            if(_emailController.text.isEmpty)
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("Insira seu email para redefinir a senha."),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                              )
                            );
                            else{
                              model.recoverPass(_emailController.text);
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(content: Text("Verifique seu email para redefinir a senha."),
                              backgroundColor: Colors.greenAccent,
                              duration: Duration(seconds: 2),
                              )
                            );
                            }
                          },
                          child: Text("Esqueci minha senha"),
                        ),
                      ),
                    ],
                  ),
            ),
          ),
            ],
          )
          );
        },
      )
    );
  }
  void _onSuccess(){
  Future.delayed(Duration(milliseconds: 1)).then((_){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=>HomePage())
    );
  });
}

void _onFail(){
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text("Falha ao autenticar usuário, verifique seus dados"),
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 2),
    )
  );
}
}