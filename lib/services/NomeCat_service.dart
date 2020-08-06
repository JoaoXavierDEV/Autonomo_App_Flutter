import 'package:autonomo_app/models/categorias_model.dart';
import 'package:autonomo_app/models/nomeCat_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NomeCatService {
  NomeCatModel _dadosCat(DocumentSnapshot snapshot) {
    return NomeCatModel(
      campos: snapshot.data,
    );
  }

  Stream<dynamic> get getCategorias {
    return Firestore.instance
        .collection('anuncio')
        .document("categorias")
        .snapshots()
        .map(_dadosCat);
    /* .map((doc) {
      return doc.data['TI'];
    });
*/
  }
}
