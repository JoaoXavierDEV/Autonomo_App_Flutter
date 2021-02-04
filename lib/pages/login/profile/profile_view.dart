import 'package:autonomo_app/components/bottomNavigationBar.dart';
import 'package:autonomo_app/components/temas/temas.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/services/auth.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:autonomo_app/styles/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as prefix0;

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formkey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  TextEditingController txtEndereco = new TextEditingController();
  dynamic fotoNova;

  //final fotoPerfil = AssetImage("lib/images/fotoPerfil/arquivo1.jpg");

  brilhoApp() {
    String temaApp = Theme.of(context).brightness.toString();
    if (temaApp == "Brightness.dark") {
      return true;
    } else {
      return false;
    }
  }

  getAllDados() {
    final user = Provider.of<User>(context);
    dynamic dados = DatabaseService(uid: user.uid).userData;
    return dados;
  }

  corApp() => brilhoApp() ? Colors.grey[700] : Colors.grey[300];

  @override
  void initState() {
    super.initState();
    // getFotoPerfil();
  }

  getFotoPerfil() async {
    final user = Provider.of<User>(context);
    final fotoPerfil = DatabaseService(uid: user.uid).getUserProfileImages();
    await fotoPerfil.then((value) {
      fotoNova = value;
    });
    return fotoNova;
  }

  String cepFOR;
  String enderecoFOR;
  String localidadeFOR;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder(
      stream: getAllDados(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          userData.endereco.forEach((key, value) {
            if (key == "logradouro") {
              enderecoFOR = value;
            }
            if (key == "cep") {
              cepFOR = value;
            }
            if (key == "localidade") {
              localidadeFOR = value;
            }
          });

          String txtTelefone = userData.telefone;
          String txtBio = userData.bio;

          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {},
              label: Text(
                'Salvar',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).buttonColor,
            ),
            /* appBar: AppBar(
              title: Text("Perfil"),
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              //elevation: 8,
              centerTitle: true,
            ),*/
            body: Container(
              // height: MediaQuery.of(context).size.height * 2,
              //height: 800,
              // color: Colors.blueGrey,
              child: Stack(
                // alignment: Alignment.center,
                // fit: StackFit.loose,
                children: [
                  Positioned.fill(
                    child: FutureBuilder<Object>(
                        future: getFotoPerfil(),
                        builder: (context, snapshot) {
                          return Container(
                            decoration: BoxDecoration(
                              //border: Border.all(style: BorderStyle.solid),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: NetworkImage(fotoNova),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          );
                        }),
                  ),
                  BackdropFilter(
                    filter: prefix0.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                  Positioned(
                    //top: 180,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Container(
                        //alignment: Alignment(17, 8),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [
                              0.155,
                              0.564,
                              1
                            ],
                                colors: [
                              /* Color(0xD0242424),
                              Color(0xFF1D1D1D),
                              Color(0xFF1D1D1D),*/
                              Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withAlpha(150),
                              Theme.of(context).scaffoldBackgroundColor,
                              Theme.of(context).scaffoldBackgroundColor,
                            ])),
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.blue.withOpacity(0.2),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width / 10,
                              left: 10,
                              right: 10,
                              //  bottom: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, right: 0),
                                  child: FutureBuilder<Object>(
                                      future: getFotoPerfil(),
                                      builder: (context, snapshot) {
                                        return Container(
                                          width: 120.0,
                                          height: 120.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF000000),
                                            image: new DecorationImage(
                                              image: NetworkImage(fotoNova),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(150.0)),
                                            border: Border.all(
                                              color: Colors.lightGreen[700],
                                              width: 5.0,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 0.0),
                                            child: Text(
                                              userData.nome.split(" ")[0] +
                                                  " " +
                                                  userData.nome.split(" ")[1],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Icon(
                                              Icons.verified_user,
                                              color: Colors.blue,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 2),
                                        child: Text(
                                            userData.email.toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline),
                                      ),
                                      RaisedButton(
                                        visualDensity: VisualDensity.compact,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        onPressed: () {
                                          _auth.SignOut();
                                        },
                                        color: Colors.red[700],
                                        textColor: Colors.white,
                                        child: Text("Sair".toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              letterSpacing: 2.0,
                                              fontWeight: FontWeight.w900,
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          ///
                          Container(
                            child: Form(
                              key: _formkey,
                              child: Column(
                                /* crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,*/
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // onChanged: (value) => txtEndereco = value,
                                      initialValue: enderecoFOR,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      //controller: txtEndereco,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        //    icon: Icon(Icons.edit),
                                        //suffixIcon: Icon(Icons.remove_red_eye),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 3.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: corApp(),
                                            width: 1.0,
                                          ),
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'Endereço',
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // onChanged: (value) => txtEndereco = value,
                                      initialValue: localidadeFOR,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      //controller: txtEndereco,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        //    icon: Icon(Icons.edit),
                                        //suffixIcon: Icon(Icons.remove_red_eye),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 3.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: corApp(),
                                            width: 1.0,
                                          ),
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'Localidade',
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: cepFOR,

                                      // onChanged: (value) => txtCep = value,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      decoration: InputDecoration(
                                        //icon: Icon(Icons.edit),
                                        //suffixIcon: Icon(Icons.remove_red_eye),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: corApp(), width: 1.0),
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'CEP',
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: userData.telefone,
                                      onChanged: (value) => txtTelefone = value,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      showCursor: true,
                                      decoration: InputDecoration(
                                        //icon: Icon(Icons.edit),
                                        //suffixIcon: Icon(Icons.remove_red_eye),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: corApp(), width: 1.0),
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'Telefone',
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: userData.bio,
                                      onChanged: (value) => txtBio = value,
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        //icon: Icon(Icons.edit),
                                        //suffixIcon: Icon(Icons.remove_red_eye),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: corApp(),
                                            width: 1.0,
                                          ),
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'Descrição',
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            margin: EdgeInsets.only(
                              left: 20,
                              top: MediaQuery.of(context).size.width / 20,
                              right: 20,
                              bottom: 55,
                            ),
                            //alignment: Alignment(17, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              //color: Color(0xFF292929),
                              color: Theme.of(context).scaffoldBackgroundColor,
                              //shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(100),
                                  offset: Offset(0, 4),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                ),
                              ],
                              /* gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [
                                      //  0.555,
                                      //  0.564,
                                      1
                                    ],
                                    colors: [
                                      Color(0xD00E0E0E),
                                      //   Color(0xFF130561),
                                      //  Color(0xFF420079),
                                    ],
                                  ),*/
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                overflow: Overflow.visible,
              ),
            ),
          );
        } else if (snapshot.error) {
          return Container(
            // color: Colors.white,
            child: Center(
              child: Loading(),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(
            // color: Colors.white,
            child: Center(
              child: Loading(),
            ),
          );
        } else {
          return Container(
            // color: Colors.white,
            child: Center(
              child: Loading(),
            ),
          );
        }
      },
    );
  }
}
