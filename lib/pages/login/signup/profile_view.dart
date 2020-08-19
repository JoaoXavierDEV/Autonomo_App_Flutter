import 'package:autonomo_app/models/user.dart';
import 'package:autonomo_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as prefix0;

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController txtEndereco = new TextEditingController();

  final fotoPerfil = AssetImage("lib/images/arquivo1.jpg");
  @override
  Widget build(BuildContext context) {
    print(txtEndereco.text);
    final user = Provider.of<User>(context);
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          String textoNovo = userData.endereco;
          return Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                await DatabaseService(uid: user.uid).updateUserData(
                    userData.nome,
                    userData.email,
                    userData.sobrenome,
                    userData.telefone,
                    userData.cep,
                    textoNovo,
                    userData.bairro,
                    userData.municipio,
                    userData.estado,
                    userData.profissao,
                    userData.bio);
                print('Salvar');
                print(textoNovo);
              },
              label: Text(
                'Salvar',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              backgroundColor: Colors.blueGrey[900],
            ),
            /* appBar: AppBar(
              title: Text("Perfil"),
              backgroundColor: Theme.of(context).accentColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              centerTitle: true,
            ),*/
            body: Container(
              // height: 400,
              // color: Colors.blueGrey,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        //border: Border.all(style: BorderStyle.solid),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: fotoPerfil,
                          fit: BoxFit.fitHeight,
                        ),
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
                              Color(0xD0242424),
                              Color(0xFF1D1D1D),
                              Color(0xFF1D1D1D),
                            ])),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        top: 10,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 30, left: 10, right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: Container(
                                      width: 120.0,
                                      height: 120.0,
                                      decoration: new BoxDecoration(
                                        color: const Color(0xFF000000),
                                        image: new DecorationImage(
                                          image: fotoPerfil,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(150.0)),
                                        border: Border.all(
                                          color: Colors.lightGreen[700],
                                          width: 5.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 0.0),
                                              child: Text(
                                                userData.nome,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    .copyWith(
                                                        color: Colors.white),
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
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            userData.email,
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
                    ],
                  ),
                  /* Positioned(
                      top: 160,
                      width: 180,
                      height: 44,
                      child: FlatButton(
                        onPressed: () => {},
                        color: Colors.green[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
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
                                style:
                                    TextStyle(fontSize: 20, color: whiteColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),*/

                  Positioned.fill(
                    top: MediaQuery.of(context).size.width / 5,
                    //top: 180,

                    //top: 10,
                    // width: MediaQuery.of(context).size.width,
                    //width: 420,
                    child: SingleChildScrollView(
                      child: Column(
                        /*mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,*/
                        children: [
                          Container(
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      onChanged: (value) => textoNovo = value,
                                      initialValue: textoNovo,
                                      style: TextStyle(color: Colors.grey[50]),
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
                                              color: Colors.grey[800],
                                              width: 1.0),
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
                                      initialValue: userData.cep,
                                      style: TextStyle(color: Colors.grey[50]),
                                      decoration: InputDecoration(
                                        //icon: Icon(Icons.edit),
                                        //suffixIcon: Icon(Icons.remove_red_eye),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[800],
                                              width: 1.0),
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
                                      initialValue: userData.profissao,
                                      style: TextStyle(color: Colors.grey[50]),
                                      decoration: InputDecoration(
                                        //icon: Icon(Icons.edit),
                                        //suffixIcon: Icon(Icons.remove_red_eye),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 5.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[800],
                                              width: 1.0),
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        hintText: 'Serviços',
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      initialValue: userData.telefone,
                                      style: TextStyle(color: Colors.grey[50]),
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
                                              color: Colors.grey[800],
                                              width: 1.0),
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
                                      style: TextStyle(color: Colors.grey[50]),
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
                                              color: Colors.grey[800],
                                              width: 1.0),
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
                              left: 26,
                              top: MediaQuery.of(context).size.width / 4,
                              right: 26,
                              bottom: 55,
                            ),
                            //alignment: Alignment(17, 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Color(0xFF292929),
                              //shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
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
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
