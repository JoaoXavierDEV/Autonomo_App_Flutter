import 'dart:io';

import 'package:autonomo_app/components/botao_widget.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:page_transition/page_transition.dart';

import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/components/testePlanodeFundo.dart';
import 'package:autonomo_app/controllers/getImage_controller.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/pages/login/signup/step01/signup_controller.dart';
import 'package:autonomo_app/pages/login/signup/step02/signup_view2.dart';

class SignupPage extends StatefulWidget {
  final Function toggleView;
  final UserData user;
  const SignupPage({
    Key key,
    this.toggleView,
    this.user,
  }) : super(key: key);
  @override
  _SignupPageState createState() => _SignupPageState();
}

UserData userData = UserData();

TextEditingController txtNomeCompleto = new TextEditingController();
TextEditingController txtEmail = new TextEditingController();
TextEditingController txtSenha = new TextEditingController();
TextEditingController txtDataNasc = new TextEditingController();
DateTime txtNewDataNasc;
TextEditingController txtCpf = new TextEditingController();

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  // AnimationController _animationController;
  final User user = User();
  final focusEmail = FocusNode();
  final focusSenha = FocusNode();
  final focusDataNasc = FocusNode();
  final focusCPF = FocusNode();
  final UserData userData = UserData();
  final _formKey = GlobalKey<FormState>();

  PickedFile imagemController;

  final _controllerGetImage = GetImageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerGetImage.dispose();
    focusEmail.dispose();
    super.dispose();
  }

// State dos Text field
  var dataFormater = new MaskTextInputFormatter(mask: '##/##/####');
  var cpfFormater = new MaskTextInputFormatter(mask: '###.###.###-##');

  bool _verSenha = true;
  final fotoPerfil = AssetImage("lib/images/arquivo.jpg");

  @override
  Widget build(BuildContext context) {
    final _controller = SignupController();
    // var temaDark = WidgetsBinding.instance.window.platformBrightness;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: azulMtEscuro,
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
            Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 2 / 100,
                          left: 30,
                          right: 30,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 0, right: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    _controllerGetImage.getImageGallery();
                                  },
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: [
                                      StreamBuilder(
                                          stream: _controllerGetImage.output,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return CircleAvatar(
                                                radius: 110,
                                                backgroundColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.pink,
                                                  radius: 100,
                                                  backgroundImage: FileImage(
                                                    File(snapshot.data.path),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return CircleAvatar(
                                                radius: 110,
                                                backgroundColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
                                                child: CircleAvatar(
                                                  onBackgroundImageError:
                                                      (exception, stackTrace) =>
                                                          {},
                                                  // backgroundColor: Colors.pink,
                                                  radius: 100,
                                                  backgroundImage: AssetImage(
                                                      'lib/images/icons/profile.png'),
                                                ),
                                              );
                                            }
                                          }),
                                      Positioned(
                                        bottom: -5,
                                        right: 2,
                                        child: GestureDetector(
                                          onTap: () {
                                            _controllerGetImage
                                                .getImageCamera();
                                          },
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: CircleAvatar(
                                              radius: 24,
                                              backgroundImage: AssetImage(
                                                  "lib/images/icons/fotoAvatar.png"),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  child: TextFormField(
                                    controller: txtNomeCompleto,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focusEmail);
                                    },
                                    validator: _controller.validarNome,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      labelText: "Nome completo",
                                      prefixIcon: Icon(
                                        LineAwesomeIcons.user,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  child: TextFormField(
                                    focusNode: focusEmail,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focusSenha);
                                    },
                                    controller: txtEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      prefixIcon: Icon(
                                        LineAwesomeIcons.envelope_1,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                    ),
                                    validator: _controller.validarEmail,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  child: TextFormField(
                                    focusNode: focusSenha,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focusDataNasc);
                                    },
                                    controller: txtSenha,
                                    keyboardType: TextInputType.text,
                                    obscureText: _verSenha,
                                    decoration: InputDecoration(
                                      labelText: "Senha",
                                      prefixIcon: Icon(
                                        LineAwesomeIcons.key,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: _verSenha
                                            ? Icon(
                                                FluentSystemIcons
                                                    .ic_fluent_eye_show_regular,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              )
                                            : Icon(
                                                FluentSystemIcons
                                                    .ic_fluent_eye_hide_regular,
                                                color: Colors.red,
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            _verSenha = !_verSenha;
                                          });
                                        },
                                      ),
                                    ),
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
                                    validator: (value) => value.isEmpty
                                        ? 'Selecione sua data de nascimento'
                                        : null,
                                    focusNode: focusDataNasc,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focusCPF);
                                    },
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
                                      prefixIcon: Icon(
                                        LineAwesomeIcons.calendar,
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      hintText: 'Data não selecionada',
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  child: TextFormField(
                                    focusNode: focusCPF,
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
                                        color:
                                            Theme.of(context).iconTheme.color,
                                      ),
                                      fillColor: Colors.red,
                                      hoverColor: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 28.0, bottom: 50),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    userData.nome = txtNomeCompleto.text;
                                    userData.email = txtEmail.text;
                                    userData.datanasc = txtNewDataNasc;
                                    userData.cpf = txtCpf.text;

                                    print(txtSenha.text);

                                    if (_controllerGetImage.newImage != null) {
                                      if (_formKey.currentState.validate()) {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            duration:
                                                Duration(milliseconds: 200),
                                            type: PageTransitionType.fade,
                                            child: SignupPage2(
                                              dadosModel: userData,
                                            ),
                                          ),
                                        );
                                      } else {}
                                      // await DatabaseService(uid: user.uid).uploadFile(_image);
                                    } else {
                                      SignupController().verificaFoto(context);
                                    }
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
