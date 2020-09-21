import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/components/testePlanodeFundo.dart';
import 'package:autonomo_app/models/result_cep.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void main() {
  runApp(Signup_page_2());
}

class Signup_page_2 extends StatefulWidget {
  Signup_page_2({Key key}) : super(key: key);

  @override
  _Signup_page_2State createState() => _Signup_page_2State();
}

TextEditingController txtrua = new TextEditingController();
TextEditingController txtCep = new TextEditingController();
TextEditingController txtMunicipio = new TextEditingController();
TextEditingController txtEstado = new TextEditingController();
TextEditingController txtBairro = new TextEditingController();

class _Signup_page_2State extends State<Signup_page_2> {
  final _formKey = GlobalKey<FormState>();
  bool exibeCampos = false;
//Formato

  var telFormater = new MaskTextInputFormatter(mask: '(##) # ####-####');
  var cepFormater = new MaskTextInputFormatter(mask: '#####-###');

//Formato

  String _currentTelefone = '';

  buscaCep(String cep) async {
    if (cep.length >= 9) {
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
        print("passou de 9");
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
          elevation: 0,
        ),
        body: new SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
            overflow: Overflow.visible,
            children: [
              Positioned(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    color: azulMtEscuro,
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 10,
                              left: 30,
                              right: 30,
                            ),
                            child: Form(
                                key: _formKey,
                                child: Column(children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 8, right: 0),
                                    child: GestureDetector(
                                      child: Container(
                                        width: 200.0,
                                        height: 200.0,
                                        decoration: new BoxDecoration(
                                          image: new DecorationImage(
                                            image: AssetImage(
                                                "lib/images/arquivo.jpg"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    inputFormatters: [telFormater],
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: "Telefone",
                                      labelStyle: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    onChanged: (value) => {
                                      setState(() => _currentTelefone = value)
                                    },
                                  ),
                                  TextFormField(
                                      controller: txtCep,
                                      inputFormatters: [cepFormater],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "CEP",
                                        labelStyle: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                      onChanged: (cep) => {buscaCep(cep)}),
                                  Container(
                                      child: exibeCampos
                                          ? Column(children: <Widget>[
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: "Endereco",
                                                  labelStyle: TextStyle(
                                                    color: Colors.black38,
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
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: "Bairro",
                                                  labelStyle: TextStyle(
                                                    color: Colors.black38,
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
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: "Município",
                                                  labelStyle: TextStyle(
                                                    color: Colors.black38,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                                controller: txtMunicipio,
                                              ),
                                            ])
                                          : null)
                                ]) //╚aqui
                                ))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
