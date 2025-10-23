import 'package:dio/dio.dart';
import 'package:inspiravida/exercicio.dart';


class ExercicioApi {
  final dio = Dio();
  String baseUrl = 'https://api.api-ninjas.com/v1';
  String baseUrlFakeApi = 'https://my-json-server.typicode.com/Rubia15/fake-api-rubia';

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

  Future<List<Exercicio>> findExerciciosFake() async {
    List<Exercicio> lista = [];
    final response = await dio.get('${baseUrlFakeApi}/exercicios');

    if(response.statusCode == 200){
      for(var json in response.data){
        Exercicio exercicio = Exercicio.fromJson(json);
        lista.add(exercicio);
      }
    }

    return lista;
  }
}
