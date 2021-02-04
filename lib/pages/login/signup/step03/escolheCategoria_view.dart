import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/pages/login/signup/step01/signup_view.dart';
import 'package:autonomo_app/services/NomeCat_service.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:autonomo_app/styles/loading.dart';

class EscolheCategoriaView extends StatefulWidget {
  // tela 01
  final File fotoPerfil;
  final String nomeCompleto;
  final String email;
  final String senha;
  final DateTime datanasc;
  final String cpf;
  // tela 02
  final String telefone;
  final Map endereco;

  const EscolheCategoriaView({
    Key key,
    this.fotoPerfil,
    this.nomeCompleto,
    this.email,
    this.senha,
    this.datanasc,
    this.cpf,
    this.telefone,
    this.endereco,
  }) : super(key: key);

  @override
  _EscolheCategoriaViewState createState() => _EscolheCategoriaViewState();
}

final Map<String, Map<String, bool>> mapa = {};
Map<String, List<dynamic>> _dadosFirebaseFinal = {};

class _EscolheCategoriaViewState extends State<EscolheCategoriaView> {
  @override
  void initState() {
    super.initState();
    _future = criarListas();
  }

  var _auth = AuthService();

  Future<Map<String, Map<String, bool>>> _future;

  Future<Map<String, Map<String, bool>>> criarListas() async {
    Future<dynamic> result = NomeCatService().getFutureCat();
    await result.then((value) {
      value.data.forEach((nomeCat, nomeSubcat) => {
            mapa[nomeCat] = {},
            nomeSubcat.forEach((element) {
              mapa[nomeCat][element] = false;
            }),
          });
    });
    return mapa;
  }

  getItems() {
    Map<String, List<dynamic>> _dadosFirebase = {};
    mapa.forEach((cat, mapSubCat) {
      mapSubCat.forEach((String key, bool value) {
        if (value == true) {
          if (_dadosFirebase[cat] is! List<dynamic>) {
            _dadosFirebase[cat] = [];
            _dadosFirebase[cat].add(key.toString());
          } else {
            _dadosFirebase[cat].add(key.toString());
          }
        }
      });
    });
    print(_dadosFirebase);
    _dadosFirebaseFinal = _dadosFirebase;
  }

  brilhoApp() {
    String temaApp = Theme.of(context).brightness.toString();
    if (temaApp == "Brightness.dark") {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////////////////////////////////////////////////
    // pega o brilho do sistema android                                                   //
    // String temaDark = WidgetsBinding.instance.window.platformBrightness.toString();    //
    ////////////////////////////////////////////////////////////////////////////////////////
    // pega o brilho do app pelo Contexto, somente depois do método build                 //
    // String temaApp = Theme.of(context).brightness.toString();                          //
    ////////////////////////////////////////////////////////////////////////////////////////

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.check,
          size: 32,
        ),
        label: Text("Concluir"),
        onPressed: () async {
          if (_dadosFirebaseFinal.isNotEmpty) {
            dynamic user = await _auth.registerWithEmailAndPassword(
                widget.email, widget.senha);

            await DatabaseService(uid: user.uid).updateUserData(
                widget.nomeCompleto,
                widget.email,
                widget.datanasc.toString(),
                widget.cpf,
                widget.telefone,
                widget.endereco,
                "Insira sua bio aqui");
            await DatabaseService(uid: user.uid)
                .categoriaUserData(_dadosFirebaseFinal);
            await DatabaseService(uid: user.uid).uploadFile(widget.fotoPerfil);
          }
        },
      ),
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
        title: Text(
          "Selecione suas categorias",
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.white, fontSize: 24),
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: mapa.keys.map((key) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 12, left: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: brilhoApp() ? azulMtEscuro : Colors.white,
                            border: Border.all(
                              color: azulMtEscuro,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ExpansionTile(
                            title: Text(
                              key.toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            initiallyExpanded: false,
                            subtitle: Text(
                              "Selecione seus serviços",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            children: [
                              new Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  //color: Colors.red,
                                  border: Border(
                                    top: BorderSide(
                                      color: brilhoApp()
                                          ? Colors.white
                                          : azulMtEscuro,
                                      width: 1.5,
                                    ),

                                    //color: azulMtEscuro,
                                    //width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  children: mapa[key].keys.map((nomeSubcat) {
                                    return CheckboxListTile(
//                                  checkColor: Theme.of(context).accentColor,
                                      contentPadding: EdgeInsets.only(left: 0),
                                      activeColor: azulMtEscuro,

                                      title: Text(nomeSubcat.toString()),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: mapa[key][nomeSubcat],
                                      onChanged: (value) {
                                        setState(() {
                                          mapa[key][nomeSubcat] = value;
                                          getItems();
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Loading(),
            );
          }
        },
      ),
    );
  }
}
