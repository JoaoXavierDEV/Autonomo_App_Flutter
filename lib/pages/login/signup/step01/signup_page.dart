import 'package:autonomo_app/pages/login/signin/login_page.dart';
import 'package:autonomo_app/pages/login/signup/step03/escolheCategoria_view.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/services/auth.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
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

  String _currentBio = '';

  String _currentcpf = '';

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
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 9, left: 30, right: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.bodyText2,
                    //controller: txtEndereco,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: "Nome completo",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).dividerColor, width: 1.0),
                      ),
                      // fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (value) =>
                        {setState(() => _currentNome = value)},
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    prefixIcon: Icon(Icons.alternate_email),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Insira um email' : null,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(
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
                TextFormField(
                  validator: (value) =>
                      CPFValidator.isValid(value) ? null : 'CPF inválido',
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "CPF",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (value) => {setState(() => _currentcpf = value)},
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Bio",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  onChanged: (value) => {setState(() => _currentBio = value)},
                ),
                FlatButton.icon(
                  color: Colors.red,
                  splashColor: Colors.yellow,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Avançar",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),

                  /*   child: Text(
                    "Avançar ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),*/
                  onPressed: () async {
                    /*   if (_formKey.currentState.validate()) {
                            dynamic user = await _auth
                              .registerWithEmailAndPassword(email, password);
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentNome,
                              email,
                              _currentSobrenome,
                              _currentTelefone,
                              _currentcpf,
                              txtCep.text,
                              txtrua.text,
                              txtBairro.text,
                              txtMunicipio.text,
                              txtEstado.text,
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
                        }*/
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
