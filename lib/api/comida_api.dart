import 'package:dio/dio.dart';
import 'package:inspiravida/domain/Comida.dart';
import 'package:inspiravida/domain/Comida_api_verdadeira.dart';

class ComidaApiFake{
  final dio = Dio();
  String baseUrl = "https://my-json-server.typicode.com/RuanMT0/fake-api-ruan";

  Future<List<Comida>> getAll () async{
    List<Comida> listaComidas = [];

    final response = await dio.get("$baseUrl/comidas");
    print(response);

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

class ComidaApi {
  final dio = Dio();
  String baseUrl = "https://api-receitas-pi.vercel.app/receitas/todas";

  Future<List<Items>> getAll () async {
    List<Items> listaItems = [];
    final response = await dio.get(baseUrl);
    print(response);

    if(response.statusCode == 200) {
      var result = response.data["items"];

      for(var json in result){
        Items item = Items.fromJson(json);
        listaItems.add(item);
      }
    } else {
      var result = response.data;
      print(result);
    }
    return listaItems;
  }
}