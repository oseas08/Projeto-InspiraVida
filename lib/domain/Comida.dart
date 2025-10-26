class Comida{
  late String pathImage;
  late String nome;
  late String descricao;

  Comida({
    required this.pathImage,
    required this.nome,
    required this.descricao
  });

  Comida.fromJson(Map<String, dynamic> json) {
    pathImage = json['pathImage'];
    nome = json['nome'];
    descricao = json['descricao'];
  }
}