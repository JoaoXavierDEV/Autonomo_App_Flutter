import 'dart:convert';
import 'dart:io';

import 'package:autonomo_app/controllers/buscaCep.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/result_cep.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/login/signup/step03/escolheCategoria_view.dart';

class SignupPage2 extends StatefulWidget {
  final UserData dadosModel;
  const SignupPage2({
    Key key,
    this.dadosModel,
  }) : super(key: key);
  @override
  _SignupPage2State createState() => _SignupPage2State();
}

TextEditingController txtrua = new TextEditingController();
TextEditingController txtCep = new TextEditingController();
TextEditingController txtMunicipio = new TextEditingController();
TextEditingController txtEstado = new TextEditingController();
TextEditingController txtBairro = new TextEditingController();
TextEditingController txtNumCasa = new TextEditingController();
TextEditingController txtComplemento = new TextEditingController();
TextEditingController txtTelefone = new TextEditingController();

var formaterTelefone = new MaskTextInputFormatter(mask: '(##) # ####-####');
var formaterCep = new MaskTextInputFormatter(mask: '#####-###');

class _SignupPage2State extends State<SignupPage2> {
  final User user = User();
  final UserData userData = UserData();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String resultado;
  bool exibeCampos = false;
  Map resultCepMap = {};
  CepModel retorno;
/*
  Future buscaCep(String cep) async {
    if (cep.length == 9) {
      var response = await http.get('https://viacep.com.br/ws/$cep/json/');
      if (response.statusCode == 200) {
        retorno = CepModel.fromJson(response.body);
        String resposta = validaCep(retorno);

        return resposta;
      } else if (response.statusCode == 400) {
        print("valor inválido para cep");
        setState(() {
          exibeCampos = false;
        });
        return "false";
        // throw Exception('Requisição inválida!');
      }
    } else {
      setState(() {
        exibeCampos = false;
      });
      return "false";
    }
  }

  String validaCep(retorno) {
    if (retorno != null) {
      if (retorno.erro == null) {
        resultCepMap = retorno.toMap();
        resultCepMap.remove('unidade');
        resultCepMap.remove('ibge');
        resultCepMap.remove('gia');
        resultCepMap.remove('erro');

        txtrua.text = retorno.logradouro;
        txtMunicipio.text = retorno.localidade;
        txtBairro.text = retorno.bairro;
        txtEstado.text = retorno.uf;
        txtComplemento.text = "";
        txtNumCasa.text = "";

        setState(() {
          exibeCampos = true;
        });
        return null;
      } else if (retorno.erro == true) {
        resultCepMap = {};

        txtrua.text = "";
        txtMunicipio.text = "";
        txtBairro.text = "";
        txtEstado.text = "";
        txtComplemento.text = "";
        txtNumCasa.text = "";

        setState(() {
          exibeCampos = false;
        });
        String texto = "CEP inválido";
        return texto;
      } else {
        return "CEP inválido";
      }
    } else {
      return "CEP vazio";
    }
  }
*/
  final blocCep = BuscaCepBloc();
  @override
  void dispose() {
    super.dispose();
    blocCep.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            LineAwesomeIcons.arrow_left,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
        //brightness: Brightness.dark,
        // backgroundColor: azulMtEscuro,
        title: Text(
          "Complete seu cadastro",
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.loose,
          overflow: Overflow.visible,
          children: [
            /*  Positioned(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Container(
                // height: 150,
                child: Center(
                  child: Text(
                    "Olá ${widget.nomeCompleto.split(" ")[0]}!",
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
                color: azulMtEscuro,
                /* decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/images/arquivo1.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),*/
              ),
            ),*/
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 5 / 100,
                left: 30,
                right: 30,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Insira suas informações de contato e endereço.",
                      style: TextStyle(
                        fontSize: 26,
                        color: azulMtEscuro,
                      ),
                    ),
                    TextFormField(
                      controller: txtTelefone,
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          value.isEmpty ? 'Digite seu telefone' : null,
                      inputFormatters: [formaterTelefone],
                      decoration: InputDecoration(
                        labelText: "Telefone",
                      ),
                    ),
                    TextFormField(
                      controller: txtCep,
                      keyboardType: TextInputType.phone,
                      /*  validator: (value) {
                        return validaCep(retorno);
                      },*/
                      inputFormatters: [formaterCep],
                      decoration: InputDecoration(
                        labelText: "CEP",
                      ),
                      // onChanged: (cep) => blocCep.url(cep),
                      onChanged: (cep) {
                        blocCep.input.add(cep);
                      },
                      validator: (value) => blocCep.resposta,
                    ),
                    StreamBuilder(
                        initialData: CepModel(),
                        stream: blocCep.output,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            CepModel model = snapshot.data;
                            txtrua.text = model.logradouro;
                            txtBairro.text = model.bairro;
                            txtEstado.text = model.uf;
                            txtMunicipio.text = model.localidade;
                            return Container(
                                child: Column(children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Endereco",
                                ),
                                controller: txtrua,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Número",
                                ),
                                controller: txtNumCasa,
                                onChanged: (value) {
                                  resultCepMap['numero'] = value;
                                  print(resultCepMap);
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Complemento",
                                ),
                                controller: txtComplemento,
                                onChanged: (value) {
                                  resultCepMap['complemento'] = value;
                                  print(resultCepMap);
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Bairro",
                                ),
                                controller: txtBairro,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Município",
                                ),
                                controller: txtMunicipio,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Estado",
                                ),
                                controller: txtEstado,
                              ),
                            ]));
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Text(
                                  "Falha na conexão",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 50),
                      child: RaisedButton(
                        visualDensity: VisualDensity.standard,
                        elevation: 6,
                        color: azulMtEscuro,
                        splashColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(900.0),
                          side: BorderSide(
                            color: Colors.blue[900],
                            width: 4,
                          ),
                        ),
                        child: Container(
                          width: 150,
                          height: 48,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Avançar",
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  LineAwesomeIcons.arrow_right,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          //  widget.dadosModel.telefone = txtTelefone.text;

                          if (_formKey.currentState.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => EscolheCategoriaView(
                                    //   meusDados: widget.dadosModel,
                                    )),
                              ),
                            );
                          }

                          // Navigator.pushNamed(context, "/botoes");
                          // await DatabaseService(uid: user.uid).uploadFile(_image);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
