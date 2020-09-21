import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/components/testePlanodeFundo.dart';
import 'package:autonomo_app/models/result_cep.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:autonomo_app/pages/login/signup/step01/signup_page.dart';
import 'package:autonomo_app/pages/login/signup/step03/escolheCategoria_view.dart';
import 'package:autonomo_app/services/auth.dart';

class SignupPage2 extends StatefulWidget {
  final File fotoPerfil;
  final String nomeCompleto;
  final String email;
  final String senha;
  final DateTime datanasc;
  final String cpf;
  final Map endereco;
  const SignupPage2({
    Key key,
    this.fotoPerfil,
    this.nomeCompleto = "Nome Nulo",
    this.email,
    this.senha,
    this.datanasc,
    this.cpf,
    this.endereco,
  }) : super(key: key);
  @override
  _SignupPage2State createState() => _SignupPage2State();
}

TextEditingController txtrua = new TextEditingController();
TextEditingController txtCep = new TextEditingController();
TextEditingController txtMunicipio = new TextEditingController();
TextEditingController txtEstado = new TextEditingController();
TextEditingController txtBairro = new TextEditingController();

var formaterTelefone = new MaskTextInputFormatter(mask: '+(##) # ####-####');
var formaterCep = new MaskTextInputFormatter(mask: '#####-###');

class _SignupPage2State extends State<SignupPage2> {
  final User user = User();
  final UserData userData = UserData();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String resultado;
  bool exibeCampos = false;
  Map resultCepMap = {};

  buscaCep(String cep) async {
    if (cep.length == 9) {
      var response = await http.get('https://viacep.com.br/ws/$cep/json/');
      if (response.statusCode == 200) {
        ResultCep retorno = ResultCep.fromJson(response.body);
        resultCepMap = retorno.toMap();
        txtrua.text = retorno.logradouro;
        txtMunicipio.text = retorno.localidade;
        txtBairro.text = retorno.bairro;
        txtEstado.text = retorno.uf;

        setState(() {
          exibeCampos = true;
        });
      } else {
        print("valor inválido para cep");
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

        actionsIconTheme: IconThemeData.fallback(),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.loose,
          overflow: Overflow.visible,
          children: [
            Positioned(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: ClipPath(
                // clipper: WaveClipperTwo(flip: false),
                clipper: CustomClipPath(),
                child: Container(
                  // height: 150,
                  color: azulMtEscuro,
                  /* decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("lib/images/arquivo1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),*/
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width / 2,
                left: 30,
                right: 30,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.nomeCompleto,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            color: Colors.blue[900],
                            fontSize: 38,
                          ),
                    ),
                    /*   Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: new BoxDecoration(
                        color: const Color(0xFF000000),
                        image: DecorationImage(
                          image: widget.fotoPerfil != null
                              ? FileImage(widget.fotoPerfil)
                              : AssetImage("lib/images/profile.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(150.0)),
                        border: Border.all(
                          color: Colors.lightGreen[500],
                          width: 5.0,
                        ),
                      ),
                    ),*/
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: [formaterTelefone],
                      decoration: InputDecoration(
                        labelText: "Telefone",
                      ),
                    ),
                    TextFormField(
                        controller: txtCep,
                        keyboardType: TextInputType.number,
                        inputFormatters: [formaterCep],
                        decoration: InputDecoration(
                          labelText: "CEP",
                        ),
                        onChanged: (cep) => {buscaCep(cep)}),
                    Container(
                      child: exibeCampos
                          ? Column(children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Endereco",
                                ),
                                controller: txtrua,
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
                            ])
                          : null,
                    ),
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
                          //if (_formKey.currentState.validate()) {}
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => EscolheCategoriaView()),
                            ),
                          );
                          // Navigator.pushNamed(context, "/botoes");
                          // await DatabaseService(uid: user.uid).uploadFile(_image);
                        },
                      ),
                    ),
                    FlatButton(
                        color: Colors.red,
                        child: Text(
                          "Cancelar",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ));
                          // widget.toggleView();
                        }),
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
