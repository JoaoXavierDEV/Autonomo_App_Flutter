// import 'package:autonomo_app/pages/home/home_page.dart';
// import 'package:autonomo_app/components/bottomNavigationBar.dart';
import 'package:autonomo_app/models/nomeCat_Model.dart';
import 'package:autonomo_app/services/NomeCat_service.dart';
import 'package:flutter/material.dart';
import 'package:autonomo_app/components/temas/temas.dart';

final temas = new Temas();

class CategoriasView extends StatefulWidget {
  @override
  _CategoriasViewState createState() => _CategoriasViewState();
}

getNomeCat() {
  dynamic aqui = NomeCatService().getCategorias;
  NomeCatModel recebeNomes = aqui;
  recebeNomes.campos.forEach((key, value) {
    print(key);
  });
  //return recebeNomes.campos;
}

class _CategoriasViewState extends State<CategoriasView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, top: 0),
              alignment: Alignment.centerLeft,
              child: Text("Categorias",
                  style: Theme.of(context).textTheme.headline6),
            ),
// view

            SizedBox(
              height: 200,
              child: GridView.count(
                padding: const EdgeInsets.all(8),
                scrollDirection: Axis.horizontal,
                crossAxisCount: 2,
                children: List.generate(
                  5,
                  (index) {
                    return Container(
                      //color: Colors.redAccent,
                      //  height: 120,
                      //  width: 120,
                      child: Column(
                        children: <Widget>[
                          Card(
                            color: Theme.of(context).buttonColor,
                            elevation: 4,
                            child: InkWell(
                              splashColor: Colors.blue[900],
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Container(
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            bottom: 32,
                                            left: 22,
                                            child: Icon(
                                              Icons.apps,
                                              color: Colors.white,
                                              size: 34,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 12,
                                            left: 16,
                                            child: FittedBox(
                                              // fit: BoxFit.scaleDown,
                                              // alignment: Alignment.center,
                                              child: Text(
                                                "items",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

// vieew
          ]),
    );
  }
}
