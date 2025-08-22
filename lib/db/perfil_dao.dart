import 'package:sqflite/sqflite.dart';
import '../domain/perfil.dart';
import 'db_helper.dart';

class PerfilDao {
  Future<List<Perfil>> listarPerfil() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM Perfil;';
    var result = await db.rawQuery(sql);

    List<Perfil> listaPerfil = [];

    await Future.delayed(Duration(seconds: 3));

    // ForEach
    for (var json in result) {
      Perfil perfil = Perfil.fromJson(json);
      listaPerfil.add(perfil);
    }

    return listaPerfil;
  }
}