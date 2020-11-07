import 'package:autonomo_app/controllers/buscaCep_widget.dart';
import 'package:flutter/material.dart';

class TestesLayout extends StatefulWidget {
  @override
  _TestesLayoutState createState() => _TestesLayoutState();
}

class _TestesLayoutState extends State<TestesLayout> {
  final testesCep = BuscaCepWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testess"),
      ),
      body: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              testesCep.input.add(value);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
