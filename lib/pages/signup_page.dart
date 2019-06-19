import 'package:flutter/material.dart';
import 'package:ihc_g2/models/user_model.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:ihc_g2/pages/homepage.dart';
import 'package:ihc_g2/pages/login_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var cpfController = new MaskedTextController(mask: '000.000.000-00');
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cpfController = TextEditingController();
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
                      SizedBox(height: 60,),
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
                            bottom: 15,
                            top: 15,
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
                            bottom: 15,
                            top: 15,
                          ),
                        ),
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        validator: (text){
                          if(text.length <= 8) return "A senha deve conter no mínimo 8 caracteres";
                        },
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person_pin, color: Colors.black),
                          hintText: "Nome",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 5,
                            right: 30,
                            bottom: 15,
                            top: 15,
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                        validator: (text){
                          if(text.isEmpty) return "Campo Obrigatório";
                        },
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person_pin, color: Colors.black),
                          hintText: "Sobrenome",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 5,
                            right: 30,
                            bottom: 15,
                            top: 15,
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                        validator: (text){
                          if(text.isEmpty) return "Campo Obrigatório";
                        },                    
                      ),
                      TextFormField(
                        controller: _cpfController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person_pin, color: Colors.black),
                          hintText: "CPF",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 5,
                            right: 30,
                            bottom: 15,
                            top: 15,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.black),
                        maxLength: 11,
                        validator: (text){
                          if(!CPFValidator.isValid(text)) return "Cpf inválido";
                        },                    
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.black,
                          child: Text("Registrar-se"),
                          textColor: Colors.white,
                          disabledColor: Colors.yellow,
                          onPressed:(){
                            if(_formKey.currentState.validate()){
                              
                              Map<String, dynamic> userData = {
                                "name": _nameController.text,
                                "lastName": _lastNameController.text,
                                "email": _emailController.text,
                                "cpf": _cpfController.text
                              };
                              
                              model.signUp(
                                userData: userData,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail
                              );
                            }
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context)=>LoginPage())
                            );
                          },
                          child: Text("Já tenho cadastro"),
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
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text("Usuário criado com sucesso"),
    backgroundColor: Colors.greenAccent,
    duration: Duration(seconds: 2),
    )
  );
  Future.delayed(Duration(seconds: 2)).then((_){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context)=>HomePage())
    );
  });
}

void _onFail(){
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text("Falha ao criar usuário"),
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 2),
    )
  );
}

}

