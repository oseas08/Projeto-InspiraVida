import 'package:sqflite/sqflite.dart';
import '../db/db_helper.dart';
import '../domain/receita.dart';
class ReceitasDao {
  Future<List<Receita>> listarReceitas() async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM PROPRIEDADE;';
    var result = await db.rawQuery(sql);

    List<Receita> listaReceitas = [];

    await Future.delayed(Duration(seconds: 3));

    // ForEach
    for (var json in result) {
      Receita propriedade = Receita.fromJson(json);
      listaReceitas.add(propriedade);
    }

    return listaReceitas;
  }
}