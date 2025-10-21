import 'package:dio/dio.dart';
import '../exercicio1.dart';

class ExercicioApi {
  final dio = Dio();
  String baseUrl = 'https://brasilapi.com.br/api';

  Future<Exercicio> findByCep(String cep) async {
    final response = await dio.get('$baseUrl/cep/v2/$cep');

    Exercicio exercicio = Exercicio.fromJson(response.data);
    return exercicio;
  }
}
