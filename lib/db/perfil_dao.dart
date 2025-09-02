import 'package:sqflite/sqflite.dart';
import '../domain/perfil2.dart';
import 'db_helper.dart';

class PerfilDao {
  Future<List<Perfil2>> listarPerfil() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM Perfil;';
    var result = await db.rawQuery(sql);

    List<Perfil2> listaPerfil = [];

    for (var json in result) {
      Perfil2 perfil = Perfil2.fromJson(json);
      listaPerfil.add(perfil);
    }

    return listaPerfil;
  }
}