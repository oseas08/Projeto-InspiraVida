class Receita {
  late String nome;
  late String descricao;
  late String pathImagem;
  late double avaliacao;
  late List<String> ingredientes;
  late List<String> modoDePreparo;

  // Construtor com os dados da nossa receita
  Receita({
    required this.nome,
    required this.descricao,
    required this.pathImagem,
    required this.avaliacao,
    required this.ingredientes,
    required this.modoDePreparo,
  });

  // Construtor para criar um objeto Receita a partir de um JSON (ex: de uma API)
  Receita.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    descricao = json['descricao'];
    pathImagem = json['pathImagem'];
    avaliacao = json['avaliacao'];
    ingredientes = json['ingredientes'].cast<String>();
    modoDePreparo = json['modoDePreparo'].cast<String>();
  }

  // Método para converter um objeto Receita em um JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['descricao'] = descricao;
    data['pathImagem'] = pathImagem;
    data['avaliacao'] = avaliacao;
    data['ingredientes'] = ingredientes;
    data['modoDePreparo'] = modoDePreparo;
    return data;
  }
}