import 'package:autonomo_app/components/categorias_view.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/categorias_model.dart';
import 'package:autonomo_app/models/nomeCat_Model.dart';
import 'package:autonomo_app/services/NomeCat_service.dart';
import 'package:autonomo_app/services/categorias_service.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as prefix0;

import 'package:provider/provider.dart';

class TestesLayout extends StatefulWidget {
  @override
  _TestesLayoutState createState() => _TestesLayoutState();
}

var ui = Image.asset("lib/images/arquivo.jpg");
var fotoInsta = NetworkImage(
    "https://instagram.fqnv1-1.fna.fbcdn.net/v/t51.2885-19/s320x320/74438701_601501560420520_6346521341910319104_n.jpg?_nc_ht=instagram.fqnv1-1.fna.fbcdn.net&_nc_ohc=vDza5C80erEAX9ZKWIh&oh=3841c188da7c3a10dfe99e23e51c820a&oe=5F5D76DF");
String dropdownValue = '';
final fotoPerfil = AssetImage("lib/images/arquivo1.jpg");

class _TestesLayoutState extends State<TestesLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF131313),

//      scaffoldBackgroundColor: Color(0xFF000000),
      appBar: AppBar(
        //backgroundColor: Colors.deepPurple[900],
        automaticallyImplyLeading: false,
        title: Text('Pagina de testes'),
        centerTitle: true,
        //elevation: 0,
      ),
      body: SizedBox(
        //height: 150,
        child: Container(
          height: 250,
          // color: Colors.blueGrey,
          child: Stack(
            alignment: Alignment.center,
            // fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  //border: Border.all(style: BorderStyle.solid),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: fotoPerfil,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              BackdropFilter(
                filter: prefix0.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
              Positioned(
                //top: 180,
                width: 500,
                height: 1000,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Container(
                    //alignment: Alignment(17, 8),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                          0.555,
                          0.564,
                          1
                        ],
                            colors: [
                          Color(0xD0242424),
                          Color(0xFF1D1D1D),
                          Color(0xFF1D1D1D),
                        ])),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Container(
                              width: 120,
                              height: 120,
                              //alignment: Alignment(0.0, 2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: fotoPerfil,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Text(
                                    "João Fernando",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "joaofernandojfmx@gmail.com",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 160,
                width: 180,
                height: 44,
                child: FlatButton(
                  onPressed: () => {},
                  color: Colors.green[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.green[600])),
                  padding: EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Icon(
                          Icons.edit,
                          color: whiteColor,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Text(
                          "Editar Perfil",
                          style: TextStyle(fontSize: 20, color: whiteColor),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
            overflow: Overflow.visible,
          ),
        ),
      ),
    );
  }
}
