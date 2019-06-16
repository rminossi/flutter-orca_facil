import 'package:flutter/material.dart';
import 'package:ihc_g2/blocs/login_bloc.dart';
import 'package:ihc_g2/widgets/input_field.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/orcafacil-45f2d.appspot.com/o/logo.png?alt=media&token=e018e302-39be-411a-9bb7-9266c6b701f2", 
                    ), 
                  InputField(
                    icon: Icons.person_outline,
                    hint: "Usuário",
                    obscure: false,
                    stream: _loginBloc.outEmail,
                    onChanged: _loginBloc.changeEmail,
                  ),
                  InputField(
                    icon: Icons.lock_outline,
                    hint: "Senha",
                    obscure: true,
                    stream: _loginBloc.outPassword,
                    onChanged: _loginBloc.changePassword,
                  ),
                  SizedBox(height: 25),
                  StreamBuilder<bool>(
                    stream: _loginBloc.outSubmitValid,
                    builder: (context, snapshot){
                      return SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.black,
                          child: Text("Entrar"),
                          onPressed: snapshot.hasData ? _loginBloc.submit: null,
                          textColor: Colors.white,
                          disabledColor: Colors.yellow,
                        ),
                      );
                    }
                  ), 
                  Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: (){
                      
                      },
                      child: Text("Cadastre-se"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: (){
                      
                      },
                      child: Text("Esqueci minha senha"),
                    ),
                  ),
                ],
              ),
        ),
      ),
        ],
      ),
    );
  }
}