import 'package:autonomo_app/models/categorias_model.dart';
import 'package:autonomo_app/models/nomeCat_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NomeCatService {
  NomeCatModel _dadosCat(DocumentSnapshot snapshot) {
    return NomeCatModel(
      campos: snapshot.data,
    );
  }

  NomeCatModel _dadosCatFuture(DocumentSnapshot snapshot) {
    return NomeCatModel(campos: snapshot.data);
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

  Future get futureCategorias async {
    return Firestore.instance
        .collection('anuncio')
        .document("categorias")
        .snapshots()
        .map(_dadosCatFuture);
    //.get();

    /*    .map((doc) {
      return doc.data;
    });*/
  }

  getFutureCat() async {
    var result = await Firestore.instance
        .collection("anuncio")
        .document("categorias")
        .get();
    return result;
  }
}
