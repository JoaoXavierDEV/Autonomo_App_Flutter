import 'dart:io';
import 'package:autonomo_app/components/loadingButton_widget.dart';
import 'package:flutter/material.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:autonomo_app/components/AnimationFluttie_widget.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/user.dart';

import 'package:autonomo_app/services/NomeCat_service.dart';

import 'package:autonomo_app/styles/loading.dart';

class EscolheCategoriaView extends StatefulWidget {
  final UserData meusDados;
  final bool busy;
  final Function func;

  const EscolheCategoriaView({
    Key key,
    this.meusDados,
    this.busy = false,
    this.func,
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
      floatingActionButton:
          /*LoadingButton(
        busy: widget.busy,
        func: widget.func,
      ),*/

          FloatingActionButton.extended(
        icon: Icon(Icons.arrow_forward),
        label: Text("Concluir"),
        onPressed: () async {
          // print(" ---- PAGE 3 " + widget.meusDados.nome);
          // print(" ---- PAGE 3 " + widget.meusDados.telefone);
          /*
          if (_dadosFirebaseFinal.isEmpty) {
            EscolheCategoriaController().alertUnselectedCategoria(context);
          } else {
            await DatabaseService(uid: user.uid)
                .categoriaUserData(_dadosFirebaseFinal);
          }*/
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
