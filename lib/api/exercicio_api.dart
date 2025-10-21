import 'package:dio/dio.dart';
import 'package:inspiravida/exercicio.dart';


class ExercicioApi {
  final dio = Dio();
  String baseUrl = 'https://api.api-ninjas.com/v1';

  Future<List<Exercicio>> findExercicios() async {
    List<Exercicio> lista = [];
    Map<String, dynamic> headers = {
      "X-Api-Key": "KDOebm+vkMrynnNykMyRmw==oX0Hjvm9S30SExL4"
    };

    final response = await dio.get(
      '$baseUrl/exercises',
      options: Options(headers: headers),
    );

    for(var json in response.data){
      Exercicio exercicio = Exercicio.fromJson(json);
      lista.add(exercicio);
    }

    return lista;
  }
}
