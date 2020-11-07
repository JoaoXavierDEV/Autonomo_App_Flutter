import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:autonomo_app/models/result_cep.dart';

final StreamController _streamController = StreamController.broadcast();

class BuscaCepBloc {
  Map resultCepMap = {};
  CepModel result2;
  String resposta = "Cep vazio - var";
  String cepIntVal;

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream
      .where((cep) => cep.length > 7)
      .asyncMap((cep) => _searchCep(cep));

  String url(String cep) => 'https://viacep.com.br/ws/$cep/json/';

  Future _searchCep(String cep) async {
    http.Response response = await http.get(url(cep));
    cepIntVal = cep;
    print(cepIntVal);

    print("_searchCep() " + cep + " length: " + cep.length.toString());
    CepModel result = CepModel.fromJson(response.body);
    if (response.statusCode == 200) {
      resposta = validaCep(result);

      return result;
    } else if (response.statusCode == 400) {
      result = null;
      return CepModel();
    } else {
      result = null;
      return CepModel();
    }
  }

  String validaCep(result) {
    if (result.erro == true) {
      return "cep nem existe";
    } else if (cepIntVal.length <= 7) {
      return "CEP vazio lenght";
    } else {
      return "cep valido -- ok ";
    }
  }

  montaCep() {
    resultCepMap = result2.toMap();
    resultCepMap.remove('unidade');
    resultCepMap.remove('ibge');
    resultCepMap.remove('gia');
    resultCepMap.remove('erro');

    return resultCepMap;
  }

  dispose() {
    print("cep encerrado");
    _streamController.close();
  }
}
