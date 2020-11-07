import 'dart:io';

class User {
  final String uid;
  User({this.uid});
}

class UserData {
  String uid;
  String nome;
  String email;
  String cpf;
  DateTime datanasc;
  String telefone;
  File fotoPerfil;
  Map endereco;
  Map profissao;
  String bio;
  UserData({
    this.uid,
    this.nome,
    this.email,
    this.cpf,
    this.datanasc,
    this.telefone,
    this.fotoPerfil,
    this.endereco,
    this.profissao,
    this.bio,
  });
}
