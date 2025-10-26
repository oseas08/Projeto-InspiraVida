import 'package:sqflite/sqflite.dart';
import 'package:inspiravida/domain/Comida.dart';
import 'package:inspiravida/db/comida_helper.dart';

class ComidaDao {
  Future<List<Comida>> listarComidas() async {
    Database db = await ComidaHelper().initDB();
    String sql = 'SELECT * FROM COMIDA;';
    var result = await db.rawQuery(sql);
    print(result);

    List<Comida> listaComidas = [];

    // ForEach
    for (var json in result) {
      Comida comida = Comida.fromJson(json);
      listaComidas.add(comida);
    }

    return listaComidas;
  }
}