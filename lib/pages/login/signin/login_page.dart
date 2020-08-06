import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/home/home_page.dart';
import 'package:autonomo_app/pages/login/signup/profile_view.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:autonomo_app/whapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autonomo_app/pages/login/signup/signup_page.dart';
import 'package:autonomo_app/pages/login/resetpassword/reset_password_page.dart';
import 'package:autonomo_app/styles/loading.dart';
import 'package:autonomo_app/services/auth.dart';
import 'package:provider/provider.dart';

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
            body: new SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 60, left: 40, right: 40),
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 128,
                        height: 128,
                        child: Image.asset("lib/images/work.png"),
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
                        style: TextStyle(fontSize: 20),
                        validator: (value) =>
                            value.isEmpty ? 'Digite um email valido' : null,
                        onChanged: (value) => email = value,
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
                        style: TextStyle(fontSize: 20),
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
                          color: Color(0xff080626),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: SizedBox.expand(
                            child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Container(
                                child: SizedBox(
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .singInrWithEmailAndPassword(email, password);

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
                        )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          //color: Color(0xff080626)
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: SizedBox.expand(
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  child: SizedBox(
                                    child: Image.asset("lib/images/google.png"),
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        child: FlatButton(
                          child: Text(
                            "Cadastre-se",
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage(),));
                            Navigator.pushNamed(context, "/signup");
                            // widget.toggleView();
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style:
                            TextStyle(color: Color(0xff080626), fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
