import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ComidaHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'comidas.db';
    String dbPath = join(path, dbName);

    await deleteDatabase(dbPath);

    Database database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: onCreate,
    );
    print(dbPath);
    return database;
  }

  Future<void> onCreate(Database db, int version) async {
    String sql = '''CREATE TABLE COMIDA (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pathImage TEXT,
    nome TEXT,
    descricao TEXT
    );''';
    await db.execute(sql);

    sql = "INSERT INTO COMIDA (pathImage, nome, descricao) VALUES ('assets/mousse.png', 'Mousse de Chocolate', 'Um mousse feito de chocolate, é meio óbvio');";
    await db.execute(sql);
    sql = "INSERT INTO COMIDA (pathImage, nome, descricao) VALUES ('assets/mousse.png', 'Mousse de Chocolate', 'Um mousse feito de chocolate, é meio óbvio');";
    await db.execute(sql);
    sql = "INSERT INTO COMIDA (pathImage, nome, descricao) VALUES ('assets/mousse.png', 'Mousse de Chocolate', 'Um mousse feito de chocolate, é meio óbvio');";
    await db.execute(sql);
  }
}