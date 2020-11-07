import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:autonomo_app/models/result_cep.dart';

final StreamController _streamController = StreamController.broadcast();

class BuscaCepWidget {
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream
      .where((cep) => cep.length > 8)
      .asyncMap((cep) => searchCep(cep));

  String url(String cep) => 'https://viacep.com.br/ws/$cep/json/';

  Future searchCep(String cep) async {
    http.Response response = await http.get(url(cep));
    print("_searchCep() " + cep + " length: " + cep.length.toString());
    CepModel result = CepModel.fromJson(response.body);

    if (response.statusCode == 200) {
      if (result.erro != true) {
      } else if (result.erro == true) {
        var dados = result.erro;
        return getEndereco(dados);
      }
    } else if (response.statusCode == 400) {
      return;
    }
  }

  dispose() {
    print("cep encerrado");
    _streamController.close();
  }

  Widget cepError(e) {
    return Text(e.toString());
  }

  Widget getEndereco(dados) {
    return Text(dados);
  }
}
