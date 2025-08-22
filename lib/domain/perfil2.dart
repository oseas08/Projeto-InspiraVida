class Perfil {
  late String nome;
  late String email;
  late String senhaantiga;
  late String senhanova;
  late String urlImage;

  Perfil({
    required this.nome,
    required this.email,
    required this.senhaantiga,
    required this.senhanova,
    required this.urlImage,
  });

  Perfil.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    senhaantiga = json['senhaantiga'];
    senhanova = json['senhanova'];
    urlImage = json['urlImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['senhaantiga'] = this.senhaantiga;
    data['senhanova'] = this.senhanova;
    data['urlImage'] = this.urlImage;
    return data;
  }
  getnome(){
    return nome;
  }
}