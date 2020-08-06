import 'package:autonomo_app/models/categorias_model.dart';
import 'package:autonomo_app/models/perfil.dart';
import 'package:autonomo_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  final String uid;
  DatabaseService({this.uid});
  //referenciando colecao de dados do perfil
  final CollectionReference perfilColecao =
      Firestore.instance.collection('perfil');
  final CollectionReference categorias =
      Firestore.instance.collection('anuncio');

  Future updateUserData(
      String nome,
      String email,
      String sobrenome,
      String telefone,
      String cep,
      String endereco,
      String bairro,
      String municipio,
      String estado,
      String profissao,
      String bio) async {
    return await perfilColecao.document(uid).setData({
      'nome': nome,
      'email': email,
      'sobrenome': sobrenome,
      'telefone': telefone,
      'cep': cep,
      'endereco': endereco,
      'bairro': bairro,
      'municipio': municipio,
      'estado': estado,
      'profissao': profissao,
      'bio': bio,
    });
  }

  // lista de dados do perfil para jogar na tela
  List<Perfil> _perfilListFromSnapshot(QuerySnapshot snaphshot) {
    return snaphshot.documents.map((doc) {
      return Perfil(
        nome: doc.data['nome'] ?? '',
        email: doc.data['email'] ?? '',
        sobrenome: doc.data['sobrenome'] ?? '',
        telefone: doc.data['telefone'] ?? '',
        cep: doc.data['cep'] ?? '',
        endereco: doc.data['endereco'] ?? '',
        bairro: doc.data['bairro'] ?? '',
        municipio: doc.data['municipio'] ?? '',
        estado: doc.data['estado'] ?? '',
        bio: doc.data['bio'] ?? '',
      );
    }).toList();
  }

  //usando dados para mostrar na tela
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      nome: snapshot.data['nome'],
      email: snapshot.data['email'],
      sobrenome: snapshot.data['sobrenome'],
      telefone: snapshot.data['telefone'],
      cep: snapshot.data['cep'],
      endereco: snapshot.data['endereco'],
      bairro: snapshot.data['bairro'],
      municipio: snapshot.data['municipio'],
      estado: snapshot.data['estado'],
      profissao: snapshot.data['profissao'],
      bio: snapshot.data['bio'],
    );
  }

  // Pegando dados do perfil
  Stream<List<Perfil>> get perfil {
    return perfilColecao.snapshots().map(_perfilListFromSnapshot);
  }

  //Pegando dados do usuario
  Stream<UserData> get userData {
    return perfilColecao.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
