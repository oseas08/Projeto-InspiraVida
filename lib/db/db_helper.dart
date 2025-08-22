import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'perfil.db';

    // C:/aqrquivos/jkdahsdja/perfil.db
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
    String sql = '''CREATE TABLE Perfil (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome REAL NOT NULL,
    email REAL,
    senhaantiga TEXT,
    senhanova TEXT,
    urlImage TEXT
    );''';

    await db.execute("sql");

    sql =
    "INSERT INTO Propriedade (nome, email, senhaantiga, senhaantiga, urlImage) VALUES ('Arthur Castro', 'arthurcastro123@gmail.com', '101010', '102030');";
    await db.execute(sql);
  }
}