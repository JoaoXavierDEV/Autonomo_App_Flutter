import 'package:autonomo_app/components/temas/temas.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class BotoesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Botões'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
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
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            "Editar Perfil",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    color: Colors.white,
                    textColor: Colors.red,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {},
                    child: Text(
                      "Add to Cart".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.blue, width: 0),
                    ),
                    onPressed: () {},
                    color: Colors.red[700],
                    textColor: Colors.white,
                    child: Text("Sair".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 0.0, right: 0.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text("Sair"),
                      onPressed: () {},
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "Sair",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  ClipOval(
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "Sair",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text("Sair"),
                    ),
                  ),
                  RaisedButton(
                    shape: StadiumBorder(),
                    onPressed: () {},
                    child: Text(
                      "Sair",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                  RaisedButton.icon(
                    color: Colors.red,
                    splashColor: Colors.yellow,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Avançar",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {},
                  ),
                  // final
                  //////////////////////
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 50),
                    child: RaisedButton(
                      visualDensity: VisualDensity.comfortable,
                      elevation: 8,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Cadastrar".toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 28,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 28.0, bottom: 30),
                    child: GestureDetector(
                      child: Container(
                        width: 180,
                        height: 48,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(100),
                              offset: Offset(0, 4),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.blue[900],
                            width: 4.0,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(900.0)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0.1,
                              1,
                            ],
                            colors: [
                              Color(0xFF0F59A3),
                              Color(0xFF033363)
                              //Color(0xFF033363),
                              //Color(0xFF021F3B)
                            ],
                          ),
                        ),
                        child: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                padding: const EdgeInsets.only(left: 10),
                                child: Icon(
                                  LineAwesomeIcons.arrow_right,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
