import 'package:flutter/material.dart';

class NovosTestes extends StatefulWidget {
  @override
  _NovosTestesState createState() => _NovosTestesState();
}

class _NovosTestesState extends State<NovosTestes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ExpansionTile'),
          //backgroundColor: Colors.deepPurple[700],
          backgroundColor: Color(0xff3700b3),
        ),
        body: Text("hue"),
      ),
    );
  }
}

void main() {
  runApp(NovosTestes());
}
