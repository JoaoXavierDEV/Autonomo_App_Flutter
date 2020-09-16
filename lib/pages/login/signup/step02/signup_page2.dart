import 'package:autonomo_app/pages/login/signup/step03/escolheCategoria_view.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:autonomo_app/services/auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:autonomo_app/models/result_cep.dart';

class SignupPage2 extends StatefulWidget {
  @override
  _SignupPage2State createState() => _SignupPage2State();
}

TextEditingController txtrua = new TextEditingController();
TextEditingController txtCep = new TextEditingController();
TextEditingController txtMunicipio = new TextEditingController();
TextEditingController txtEstado = new TextEditingController();
TextEditingController txtBairro = new TextEditingController();

class _SignupPage2State extends State<SignupPage2> {
  final User user = User();
  final UserData userData = UserData();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

// State dos Text field

  String resultado;
  bool exibeCampos = false;
  // Cadastro
  String _currentTelefone = '';

  // Cadastro
  String error = '';

  buscaCep(String cep) async {
    if (cep.length >= 8) {
      var response = await http.get('https://viacep.com.br/ws/$cep/json/');
      if (response.statusCode == 200) {
        ResultCep retorno = ResultCep.fromJson(response.body);

        txtrua.text = retorno.logradouro;
        txtMunicipio.text = retorno.localidade;
        txtBairro.text = retorno.bairro;
        txtEstado.text = retorno.uf;

        setState(() {
          exibeCampos = true;
        });
      } else {
        print("passou de 8");
        throw Exception('Requisição inválida!');
      }
    } else {
      setState(() {
        exibeCampos = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 40, right: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Telefone",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (value) =>
                      {setState(() => _currentTelefone = value)},
                ),

                TextFormField(
                    controller: txtCep,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "CEP",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    onChanged: (cep) => {buscaCep(cep)}),
                //Container
                Container(
                  child: exibeCampos
                      ? Column(children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Endereco",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            controller: txtrua,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Bairro",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            controller: txtBairro,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Município",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            controller: txtMunicipio,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Estado",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            controller: txtEstado,
                          ),
                        ])
                      : null,
                ),

                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: corBarraNavegacao,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          //        await Navigator.pushReplacement(context,     MaterialPageRoute(
                          //          builder: (context) => HomePage()));
                          await Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      HomePage()),
                              ModalRoute.withName("/home"));
                        } else {
                          print("falha nos parametros");
                        }
                      },
                    ),
                  ),
                ),

                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: FlatButton(
                      child: Text(
                        "Cancelar",
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                        // widget.toggleView();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
