import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/services/NomeCat_service.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:autonomo_app/styles/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EscolheCategoriaView extends StatefulWidget {
  const EscolheCategoriaView({Key key}) : super(key: key);

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

            /*  nomeSubcat.forEach((element) {
                    listaSubCatNew.add(element);
                  }),
*/
            /* if (listaCheckBox.length < numCampos)
                    {
                      for (int i = 0; i < listaSubCatNew.length; i++)
                        {
                          listaCheckBox[listaSubCatNew[i]] = false,
                        }
                    }
*/
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () async {
          await DatabaseService(uid: user.uid)
              .categoriaUserData(_dadosFirebaseFinal);
        },
      ),
      appBar: AppBar(
        title: Text("Selecione suas categorias"),
        automaticallyImplyLeading: false,
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
                      return ExpansionTile(
                        title: Text(
                          key.toUpperCase(),
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: 18,
                              ),
                        ),
                        initiallyExpanded: false,
                        subtitle: Text(
                          "Selecione seus serviços",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        backgroundColor: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.9),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          size: 32,
                          color: Color(0xff3700b3),
                        ),
                        children: [
                          new Container(
                            child: Column(
                              children: mapa[key].keys.map((nomeSubcat) {
                                return CheckboxListTile(
                                  //checkColor: Theme.of(context).accentColor,
                                  activeColor: corBarraNavegacao,
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
