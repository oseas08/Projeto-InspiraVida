import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'receitas.db'; // Nome do banco de dados alterado

    String dbPath = join(path, dbName);
    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: onCreate,
    );

    print(dbPath);
    return database;
  }

  Future<void> onCreate(Database db, int version) async {
    // SQL para criar a tabela Receita
    String sql = '''CREATE TABLE Receita (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      descricao TEXT,
      pathImagem TEXT,
      avaliacao REAL,
      ingredientes TEXT,
      modoDePreparo TEXT
    );''';
    await db.execute(sql);

    // Dados da receita de mousse
    String nome = 'MOUSSE DE CHOCOLATE';
    String descricao = 'A mousse de chocolate é uma sobremesa clássica, elegante e irresistivelmente cremosa, perfeita para qualquer ocasião.';
    String pathImagem = 'assets/mousse.png';
    double avaliacao = 4.5;

    // Convertendo as listas em uma única String com um separador '|'
    List<String> ingredientesList = [
      '2 latas de creme de leite',
      '8 colheres de chocolate de sua preferência',
      '1 lata de leite condensado',
      '1 pacote de gelatina sem sabor',
    ];
    String ingredientes = ingredientesList.join('|');

    List<String> modoDePreparoList = [
      'No liquidificador adicione o creme de leite, leite condensado e o chocolate em pó. Bata por 2 minutos.',
      'Derreta a gelatina e adicione junto aos ingredientes e bata até misturar.',
      'Leve à geladeira e deixe até ficar consistente.',
    ];
    String modoDePreparo = modoDePreparoList.join('|');

    // SQL para inserir a receita de mousse na tabela
    sql = "INSERT INTO Receita (nome, descricao, pathImagem, avaliacao, ingredientes, modoDePreparo) VALUES (?, ?, ?, ?, ?, ?);";
    await db.execute(sql, [nome, descricao, pathImagem, avaliacao, ingredientes, modoDePreparo]);
  }
}