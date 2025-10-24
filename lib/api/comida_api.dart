
import 'package:dio/dio.dart';
import 'package:inspiravida/domain/Comida.dart';

class ComidaApi{
  final dio = Dio();
  String baseUrl = "https://my-json-server.typicode.com/RuanMT0/fake-api-ruan";

  Future<List<Comida>> getAll () async{
    List<Comida> listaComidas = [];

    final response = await dio.get("$baseUrl/comidas");

    if(response.statusCode == 200){
      var result = response.data;
      for (var json in result) {
        Comida comida = Comida.fromJson(json);
        listaComidas.add(comida);
      }
    }
    return listaComidas;
  }
}