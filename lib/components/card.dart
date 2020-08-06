import 'package:flutter/material.dart';
import 'package:autonomo_app/components/temas/temas.dart';
final temas = new Temas();

class CardHome extends StatefulWidget {
  @override
  _CardHomeState createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2, top: 2),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 180,
            child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.horizontal,
                    itemCount: 9,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // color: Colors.redAccent,
                        height: 150,
                        width: 340,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              color: Colors.blue[700],
                              elevation: 8,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 150,
                                    // width: 150,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned.fill(
                                          child: Image.asset(
                                              'lib/images/arquivo2.gif',
                                              fit: BoxFit.cover),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Nome do usuario",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
          ),),
        ],
      ),
    );
  }
}
