import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/pages/login/signup/step01/signup_view.dart';

import 'package:autonomo_app/whapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:autonomo_app/pages/login/resetpassword/reset_password_page.dart';
import 'package:autonomo_app/styles/loading.dart';
import 'package:autonomo_app/services/auth.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  LoginPage({this.toggleView});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void initState() {
    super.initState();
    logaste();
  }

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  Future<bool> logaste() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    bool logado = false;
    if (user == null) {
      print("Usuario nulo = vá para login // $logado");
      setState(() {
        logado = false;
      });
    } else {
      setState(() {
        logado = true;
      });
      print("Usuario autenticado = vá para perfil // $logado");
    }
    return logado;
  }

  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    // print(logado);
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFF033363),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 400,
                          height: 300,
                          child: Image.asset("lib/images/logo/logo.png"),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[500],
                                  width: 1.5,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText: "E-mail",
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Colors.white,
                              )),
                          style: TextStyle(fontSize: 20),
                          validator: (value) =>
                              value.isEmpty ? 'Digite um email valido' : null,
                          onChanged: (value) => email = value,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey[500],
                                width: 1.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                            labelText: "Senha",
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          validator: (value) => value.length < 6
                              ? 'A senha deve ter mais de 6 digitos'
                              : null,
                          onChanged: (value) => password = value,
                        ),
                        Container(
                          height: 40,
                          alignment: Alignment.centerRight,
                          child: FlatButton(
                            child: Text(
                              "Recuperar Senha",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage(),
                                  ));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: verdeSecundario,
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.singInrWithEmailAndPassword(
                                        email, password);

                                if (result != null) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Whapper()),
                                      (route) => false);
                                }

                                if (result == null) {
                                  setState(() {
                                    error = 'Email ou senha invalidos';
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: 60,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              //color: Color(0xff080626)
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                            ),
                            child: FlatButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Login com conta do google",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black38,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: SizedBox(
                                      child: Image.asset(
                                          "lib/images/icons/google.png"),
                                      height: 20,
                                      width: 20,
                                    ),
                                  )
                                ],
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          child: FlatButton(
                            child: Text(
                              "Cadastre-se",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SignupPage())),
                              );
                              // widget.toggleView();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
