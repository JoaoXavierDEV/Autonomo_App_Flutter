import 'dart:io';
import 'package:autonomo_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DatabaseService extends ChangeNotifier {
  final String uid;
  DatabaseService({this.uid});
  //referenciando colecao de dados do perfil
  final CollectionReference perfilColecao =
      Firestore.instance.collection('perfil');
  final CollectionReference categorias =
      Firestore.instance.collection('anuncio');
  FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://autonomo-app-c3bdd.appspot.com");

  Future updateUserData(
    String nome,
    String email,
    String sobrenome,
    String cpf,
    String telefone,
    Map endereco,
    String bio,
  ) async {
    return await perfilColecao.document(uid).setData({
      'nome': nome,
      'email': email,
      'sobrenome': sobrenome,
      'subcategoria': cpf,
      'telefone': telefone,
      'endereco': endereco,
      'bio': bio,
    });
  }

  // lista de dados do perfil para jogar na tela
  List<UserData> _perfilListFromSnapshot(QuerySnapshot snaphshot) {
    return snaphshot.documents.map((doc) {
      return UserData(
        nome: doc.data['nome'] ?? '',
        email: doc.data['email'] ?? '',
        cpf: doc.data['cpf'] ?? '',
        telefone: doc.data['telefone'] ?? '',
        endereco: doc.data['endereco'] ?? '',
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
      cpf: snapshot.data['cpf'],
      telefone: snapshot.data['telefone'],
      endereco: snapshot.data['endereco'],
      profissao: snapshot.data['profissao'],
      bio: snapshot.data['bio'],
    );
  }

  // Pegando dados do perfil
  Stream<List<UserData>> get perfil {
    return perfilColecao.snapshots().map(_perfilListFromSnapshot);
  }

  //Pegando dados do usuario
  Stream<UserData> get userData {
    return perfilColecao.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future categoriaUserData(Map profissao) async {
    return await perfilColecao.document(uid).updateData({
      'profissao': profissao,
    });
  }

  // Enviando a imagem
  Future uploadFile(File file) async {
    var storageRef = _storage.ref().child("Usuarios/$uid/Perfil/Foto");
    var uploadTask = storageRef.putFile(file);
    var completedTask = await uploadTask.onComplete;
    String downloadUrl = await completedTask.ref.getDownloadURL();
    print(downloadUrl);

    return downloadUrl;
  }

  // Pegando url da imagem
  Future getUserProfileImages() async {
    return await _storage
        .ref()
        .child("Usuarios/$uid/Perfil/Foto")
        .getDownloadURL();
  }
}
