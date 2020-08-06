import 'package:autonomo_app/components/categorias_view.dart';
import 'package:autonomo_app/models/categorias_model.dart';
import 'package:autonomo_app/models/nomeCat_Model.dart';
import 'package:autonomo_app/services/NomeCat_service.dart';
import 'package:autonomo_app/services/categorias_service.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class TestesLayout extends StatefulWidget {
  @override
  _TestesLayoutState createState() => _TestesLayoutState();
}

String dropdownValue = '';

class _TestesLayoutState extends State<TestesLayout> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // stream: CategoriasService().getCategorias,
        stream: NomeCatService().getCategorias,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Categorias categorias = snapshot.data;
            NomeCatModel categorias = snapshot.data;

            print(categorias.campos[1]);

            categorias.campos.forEach((key, value) {
              // print(key);
              // print(value);
            });
            return Scaffold(
              backgroundColor: Color(0xFF272727),
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text('Pagina de testes'),
                centerTitle: true,
              ),
              body: Center(
                  child: Container(
                      child: Text(
                "Pag de testes",
                style: TextStyle(color: Colors.white),
              ))),
            );
          } else {
            return Container(
              color: Colors.red,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
