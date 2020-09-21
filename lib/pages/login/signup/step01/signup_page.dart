import 'dart:io';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/components/testePlanodeFundo.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/login/signup/step02/page2.dart';
import 'package:autonomo_app/pages/login/signup/step02/signup_page2.dart';

import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignupPage extends StatefulWidget {
  final Function toggleView;
  SignupPage({this.toggleView});

  @override
  _SignupPageState createState() => _SignupPageState();
}

TextEditingController txtNomeCompleto = new TextEditingController();
TextEditingController txtEmail = new TextEditingController();
TextEditingController txtSenha = new TextEditingController();
TextEditingController txtDataNasc = new TextEditingController();
DateTime txtNewDataNasc;
TextEditingController txtCpf = new TextEditingController();

class _SignupPageState extends State<SignupPage> {
  final User user = User();
  final UserData userData = UserData();
  final _formKey = GlobalKey<FormState>();
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

// State dos Text field
  var dataFormater = new MaskTextInputFormatter(mask: '##/##/####');
  var cpfFormater = new MaskTextInputFormatter(mask: '###.###.###-##');

  bool _verSenha = true;
  final fotoPerfil = AssetImage("lib/images/arquivo.jpg");

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
          //shadowColor: Colors.black,
          //brightness: Brightness.dark,
          // backgroundColor: azulMtEscuro,
          title: Text(
            "Dados pessoais",
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontSize: 24),
          ),
        ),
        body: SingleChildScrollView(
          child:
              Stack(fit: StackFit.loose, overflow: Overflow.visible, children: [
            Positioned(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: ClipPath(
                // clipper: WaveClipperTwo(flip: false),
                clipper: CustomClipPath(),
                child: Container(
                  //height: 250,
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

            /* Positioned(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            child: Container(
                //height: 500.0,
                ),
            painter: CurvePainter(),
          ),
        ),*/
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
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, right: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    width: 200.0,
                                    height: 200.0,
                                    decoration: new BoxDecoration(
                                      color: const Color(0xFF000000),
                                      image: new DecorationImage(
                                        image: _image == null
                                            ? AssetImage(
                                                "lib/images/profile.png")
                                            : FileImage(_image),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(150.0)),
                                      border: Border.all(
                                        color: Colors.lightGreen[500],
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  //color: Colors.grey[50],
                                  child: TextFormField(
                                    controller: txtNomeCompleto,
                                    validator: (value) => value.isEmpty
                                        ? 'Insira seu nome'
                                        : null,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      labelText: "Nome completo",
                                      prefixIcon: Icon(LineAwesomeIcons.user),
                                    ),
                                    //onChanged: (value) => txtNomeCompleto.text = value,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  child: TextFormField(
                                    controller: txtEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      prefixIcon:
                                          Icon(LineAwesomeIcons.envelope_1),
                                    ),
                                    validator: (value) => value.isEmpty
                                        ? 'Insira um email'
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: AnimatedContainer(
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(seconds: 5),
                                  child: TextFormField(
                                    controller: txtSenha,
                                    keyboardType: TextInputType.text,
                                    obscureText: _verSenha,
                                    decoration: InputDecoration(
                                        labelText: "Senha",
                                        prefixIcon: Icon(LineAwesomeIcons.key),
                                        suffixIcon: IconButton(
                                          icon: _verSenha
                                              ? Icon(FluentSystemIcons
                                                  .ic_fluent_eye_show_regular)
                                              : Icon(FluentSystemIcons
                                                  .ic_fluent_eye_hide_regular),
                                          onPressed: () {
                                            setState(() {
                                              _verSenha = !_verSenha;
                                            });
                                          },
                                        )),
                                    validator: (value) => value.length < 6
                                        ? 'A senha é muito curta'
                                        : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Container(
                                  child: TextFormField(
                                    controller: txtDataNasc,
                                    inputFormatters: [dataFormater],
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime(1995),
                                        firstDate: DateTime(1970),
                                        lastDate: DateTime(2021),
                                      ).then((value) {
                                        setState(() {
                                          txtDataNasc.text =
                                              DateFormat('dd/MM/y', 'pt_BR')
                                                  .format(value)
                                                  .toString();
                                        });
                                        txtNewDataNasc = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Data de nascimento",
                                      prefixIcon:
                                          Icon(LineAwesomeIcons.calendar),
                                      hintText: 'Data não selecionada',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  child: TextFormField(
                                    controller: txtCpf,
                                    validator: (value) {
                                      if (CPFValidator.isValid(value)) {
                                        print(value + ' ok');
                                        return null;
                                      } else {
                                        return 'CPF inválido';
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [cpfFormater],
                                    decoration: InputDecoration(
                                      labelText: "CPF",
                                      prefixIcon: Icon(
                                        FluentSystemIcons
                                            .ic_fluent_patient_regular,
                                      ),
                                      fillColor: Colors.red,
                                      hoverColor: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 28.0, bottom: 50),
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
                                    width: 200,
                                    height: 48,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Avançar".toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w100,
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
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
                                    /*   if (_formKey.currentState.validate()) {
                                  // Se o form for válido exibe um a snackbar
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Dados processados com sucesso')));
                                }*/

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => SignupPage2(
                                              nomeCompleto:
                                                  txtNomeCompleto.text,
                                              cpf: txtCpf.text,
                                              datanasc: txtNewDataNasc,
                                              email: txtEmail.text,
                                              fotoPerfil: _image,
                                              senha: txtSenha.text,
                                            )),
                                      ),
                                    );
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
              ],
            ),
            //)
          ]),
        ));
  }
}
