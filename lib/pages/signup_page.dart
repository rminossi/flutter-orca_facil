import 'package:flutter/material.dart';
import 'package:ihc_g2/widgets/input_field.dart';
import 'package:ihc_g2/blocs/signup_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _signUpBloc = SignUpBloc();
  var cpfController = new MaskedTextController(mask: '000.000.000-00');

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
                  InputField(
                    icon: Icons.person_outline,
                    hint: "Usuário",
                    obscure: false,
                    stream: _signUpBloc.outEmail,
                    onChanged: _signUpBloc.changeEmail,
                  ),
                  InputField(
                    icon: Icons.lock_outline,
                    hint: "Senha",
                    obscure: true,
                    stream: _signUpBloc.outPassword,
                    onChanged: _signUpBloc.changePassword,
                  ),
                  InputField(
                    icon: Icons.perm_identity,
                    hint: "Nome",
                    obscure: false,
                    stream: _signUpBloc.outName,
                    onChanged: _signUpBloc.changeName,
                  ),
                  InputField(
                    icon: Icons.perm_identity,
                    hint: "Sobrenome",
                    obscure: false,
                    stream: _signUpBloc.outlastName,
                    onChanged: _signUpBloc.changeLastName,
                  ),
                 StreamBuilder(
                   stream: _signUpBloc.outCpf,
                   builder: (context, snapshot){
                     return  TextField(
                      controller: cpfController,
                      onChanged: _signUpBloc.changeCpf,
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
                          bottom: 30,
                          top: 30,
                        ),
                      errorText: snapshot.hasError ? snapshot.error : null,
                      ),
                      style: TextStyle(color: Colors.black),
                    );
                  }
                 ),
                  SizedBox(height: 25),
                  StreamBuilder<bool>(
                    stream: _signUpBloc.outSubmitValid,
                    builder: (context, snapshot){
                      return SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.black,
                          child: Text("Entrar"),
                          onPressed: snapshot.hasData ? _signUpBloc.submit: null,
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
                      child: Text("Já tenho cadastro"),
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