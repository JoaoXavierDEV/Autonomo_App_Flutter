import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:autonomo_app/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:autonomo_app/models/result_cep.dart';
import 'package:autonomo_app/services/database.dart';

class SignupPage extends StatefulWidget {
  final Function toggleView;
  SignupPage({this.toggleView});

  @override
  _SignupPageState createState() => _SignupPageState();
}

TextEditingController txtrua = new TextEditingController();
TextEditingController txtCep = new TextEditingController();
TextEditingController txtMunicipio = new TextEditingController();
TextEditingController txtEstado = new TextEditingController();
TextEditingController txtBairro = new TextEditingController();

class _SignupPageState extends State<SignupPage> {
  final User user = User();
  final UserData userData = UserData();
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

// State dos Text field

  String resultado;
  bool exibeCampos = false;
  // Cadastro
  String email = '';
  String password = '';
  String _currentNome = '';
  String _currentSobrenome = '';
  String _currentTelefone = '';
  String _currentCep = txtCep.text;
  String _currentEndereco = txtrua.text;
  String _currentBairro = txtBairro.text;
  String _currentMunicipio = txtMunicipio.text;
  String _currentEstado = txtEstado.text;
  String _currentProfissao = '';
  String _currentBio = '';

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
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment(0.0, 1.15),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: AssetImage("lib/images/profile.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Container(
                    height: 56,
                    width: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xff080626),
                      border: Border.all(
                        width: 4.0,
                        color: const Color(0xFFFFFFFF),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(56),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: FlatButton(
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "E-mail",
                      labelStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      )),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Insira um email' : null,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  validator: (value) =>
                      value.length < 6 ? 'A senha é muito curta' : null,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (value) => {setState(() => _currentNome = value)},
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Sobrenome",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (value) =>
                      {setState(() => _currentSobrenome = value)},
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                  onChanged: (value) =>
                      {setState(() => _currentTelefone = value)},
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: txtCep,
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
                //Container
                Container(
                  child: exibeCampos
                      ? Column(children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                            keyboardType: TextInputType.text,
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
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Estado",
                              labelStyle: TextStyle(
                                color: Colors.black38,
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Profissão",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (value) =>
                      {setState(() => _currentProfissao = value)},
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Bio",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (value) => {setState(() => _currentBio = value)},
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color(0xff080626),
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
                          dynamic user = await _auth
                              .registerWithEmailAndPassword(email, password);
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentNome,
                              email,
                              _currentSobrenome,
                              _currentTelefone,
                              txtCep.text,
                              txtrua.text,
                              txtBairro.text,
                              txtMunicipio.text,
                              txtEstado.text,
                              _currentProfissao,
                              _currentBio);

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
                SizedBox(
                  height: 20,
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
