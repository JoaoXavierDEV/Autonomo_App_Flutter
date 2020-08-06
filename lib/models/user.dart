class User {
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final String nome;
  final String email;
  final String sobrenome;
  final String telefone;
  //endereço
  final String cep;
  final String bairro;
  final String municipio;
  final String estado;
  final String endereco;
  //Profissão
  final String profissao;
  final String bio;
  UserData({
    this.uid,
    this.nome,
    this.email,
    this.sobrenome,
    this.telefone,
    this.cep,
    this.bairro,
    this.municipio,
    this.estado,
    this.endereco,
    this.profissao,
    this.bio,
  });
}
