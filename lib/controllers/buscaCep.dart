import 'package:autonomo_app/services/via_cep_service.dart';
// import 'package:http/http.dart' as http;

pegaCep(String cep) {
          
  ViaCepService.fetchCep(cep: cep)
      .then((response) => {
            // print(),
          }
        )

      .catchError((onError) {
    print("não localizado");
  });

  
}

