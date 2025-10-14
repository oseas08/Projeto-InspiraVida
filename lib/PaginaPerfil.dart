import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DadosUsuario {
  final String nome;
  final String email;
  final String telefone;
  final String foto;
  final String pais;
  final String cidade;

  DadosUsuario({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.foto,
    required this.pais,
    required this.cidade,
  });

  factory DadosUsuario.fromJson(Map<String, dynamic> json) {
    return DadosUsuario(
      nome: '${json['name']['first']} ${json['name']['last']}',
      email: json['email'],
      telefone: json['phone'],
      foto: json['picture']['large'],
      pais: json['location']['country'],
      cidade: json['location']['city'],
    );
  }
}

class EstatisticasApp {
  final int diasAtivo;
  final int configuracoesSalvas;
  final int acessosRealizados;
  final String ultimoAcesso;

  EstatisticasApp({
    required this.diasAtivo,
    required this.configuracoesSalvas,
    required this.acessosRealizados,
    required this.ultimoAcesso,
  });

  factory EstatisticasApp.fromJson(Map<String, dynamic> json) {
    return EstatisticasApp(
      diasAtivo: json['days_active'],
      configuracoesSalvas: json['settings_saved'],
      acessosRealizados: json['total_access'],
      ultimoAcesso: json['last_access'],
    );
  }
}

class ServicoAPI {
  // API VERDADEIRA - RandomUser API
  static Future<DadosUsuario> buscarUsuarioReal() async {
    try {
      final response = await http.get(
        Uri.parse('https://randomuser.me/api/'),
      );

      if (response.statusCode == 200) {
        final dados = json.decode(response.body);
        return DadosUsuario.fromJson(dados['results'][0]);
      } else {
        throw Exception('Erro ao carregar dados do usuário');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // API FAKE - JSONPlaceholder (simulando estatísticas)
  static Future<EstatisticasApp> buscarEstatisticasFake() async {
    try {
      // Usando JSONPlaceholder como API fake e transformando os dados
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
      );

      if (response.statusCode == 200) {
        final dados = json.decode(response.body);

        // Transformando os dados fake em estatísticas simuladas
        return EstatisticasApp(
          diasAtivo: dados['id'] * 15, // Simulando dias
          configuracoesSalvas: dados['address']['geo']['lat'].hashCode.abs() % 50,
          acessosRealizados: dados['username'].length * 42,
          ultimoAcesso: 'Hoje às ${DateTime.now().hour}:${DateTime.now().minute}',
        );
      } else {
        throw Exception('Erro ao carregar estatísticas');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  // Buscar ambos os dados simultaneamente
  static Future<Map<String, dynamic>> buscarTodosDados() async {
    try {
      final resultados = await Future.wait([
        buscarUsuarioReal(),
        buscarEstatisticasFake(),
      ]);

      return {
        'usuario': resultados[0] as DadosUsuario,
        'estatisticas': resultados[1] as EstatisticasApp,
      };
    } catch (e) {
      rethrow;
    }
  }
}

class PaginaPerfil extends StatefulWidget {
  const PaginaPerfil({super.key});

  @override
  State<PaginaPerfil> createState() => _PaginaPerfilState();
}

class _PaginaPerfilState extends State<PaginaPerfil> {
  late Future<Map<String, dynamic>> _futureDados;

  @override
  void initState() {
    super.initState();
    _futureDados = ServicoAPI.buscarTodosDados();
  }

  void _recarregarDados() {
    setState(() {
      _futureDados = ServicoAPI.buscarTodosDados();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF123870),
        body: construirCorpo(),
      ),
    );
  }

  construirCorpo() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _futureDados,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return construirCarregamento();
        } else if (snapshot.hasError) {
          return construirErro(snapshot.error.toString());
        } else if (snapshot.hasData) {
          final usuario = snapshot.data!['usuario'] as DadosUsuario;
          final estatisticas = snapshot.data!['estatisticas'] as EstatisticasApp;
          return construirConteudo(usuario, estatisticas);
        } else {
          return construirErro('Nenhum dado disponível');
        }
      },
    );
  }

  Widget construirCarregamento() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
          SizedBox(height: 20),
          construirTexto(
            texto: 'Carregando perfil...',
            cor: Colors.white70,
            tamanhoFonte: 16.0,
          ),
        ],
      ),
    );
  }

  Widget construirErro(String erro) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.white70,
            ),
            SizedBox(height: 20),
            construirTexto(
              texto: 'Erro ao carregar dados',
              cor: Colors.white,
              tamanhoFonte: 20.0,
              pesoFonte: FontWeight.w600,
            ),
            SizedBox(height: 10),
            construirTexto(
              texto: erro,
              cor: Colors.white70,
              tamanhoFonte: 14.0,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _recarregarDados,
              icon: Icon(Icons.refresh),
              label: Text('Tentar Novamente'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0097b2),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget construirConteudo(DadosUsuario usuario, EstatisticasApp estatisticas) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            construirCabecalhoPerfil(usuario),
            SizedBox(height: 30),

            // Seção de Informações Pessoais (API Real)
            construirSecaoTitulo('Informações Pessoais', Icons.person, 'API Real'),
            SizedBox(height: 16),
            construirCardInfo(Icons.email, 'Email', usuario.email),
            SizedBox(height: 12),
            construirCardInfo(Icons.phone, 'Telefone', usuario.telefone),
            SizedBox(height: 12),
            construirCardInfo(Icons.location_city, 'Cidade', usuario.cidade),
            SizedBox(height: 12),
            construirCardInfo(Icons.public, 'País', usuario.pais),

            SizedBox(height: 30),

            // Seção de Estatísticas (API Fake)
            construirSecaoTitulo('Estatísticas de Uso', Icons.analytics, 'API Fake'),
            SizedBox(height: 16),
            construirCardEstatistica(
              Icons.calendar_today,
              'Dias Ativo',
              estatisticas.diasAtivo.toString(),
              Colors.blue,
            ),
            SizedBox(height: 12),
            construirCardEstatistica(
              Icons.settings,
              'Configurações Salvas',
              estatisticas.configuracoesSalvas.toString(),
              Colors.green,
            ),
            SizedBox(height: 12),
            construirCardEstatistica(
              Icons.touch_app,
              'Acessos Realizados',
              estatisticas.acessosRealizados.toString(),
              Colors.orange,
            ),
            SizedBox(height: 12),
            construirCardInfo(
              Icons.access_time,
              'Último Acesso',
              estatisticas.ultimoAcesso,
            ),

            SizedBox(height: 40),
            construirBotoes(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget construirCabecalhoPerfil(DadosUsuario usuario) {
    return Column(
      children: [
        SizedBox(height: 20),
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                image: DecorationImage(
                  image: NetworkImage(usuario.foto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0277BD),
                ),
                child: Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        construirTexto(
          texto: usuario.nome,
          tamanhoFonte: 24.0,
          pesoFonte: FontWeight.w600,
          cor: Colors.white,
        ),
        SizedBox(height: 8),
        construirTexto(
          texto: 'Perfil do Usuário',
          tamanhoFonte: 14.0,
          cor: Colors.white70,
        ),
      ],
    );
  }

  Widget construirSecaoTitulo(String titulo, IconData icone, String badge) {
    return Row(
      children: [
        Icon(icone, color: Colors.white, size: 24),
        SizedBox(width: 12),
        construirTexto(
          texto: titulo,
          tamanhoFonte: 18.0,
          pesoFonte: FontWeight.w600,
          cor: Colors.white,
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: construirTexto(
            texto: badge,
            tamanhoFonte: 12.0,
            cor: Colors.white,
            pesoFonte: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget construirCardInfo(IconData icone, String titulo, String valor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icone, color: Colors.black54, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  construirTexto(
                    texto: titulo,
                    tamanhoFonte: 14.0,
                    cor: Colors.black54,
                  ),
                  SizedBox(height: 4),
                  construirTexto(
                    texto: valor,
                    tamanhoFonte: 16.0,
                    pesoFonte: FontWeight.w500,
                    cor: Colors.black87,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget construirCardEstatistica(
      IconData icone,
      String titulo,
      String valor,
      Color cor,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: cor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icone, color: cor, size: 28),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  construirTexto(
                    texto: titulo,
                    tamanhoFonte: 14.0,
                    cor: Colors.black54,
                  ),
                  SizedBox(height: 4),
                  construirTexto(
                    texto: valor,
                    tamanhoFonte: 24.0,
                    pesoFonte: FontWeight.w700,
                    cor: cor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget construirBotoes() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: _recarregarDados,
            icon: Icon(Icons.refresh, color: Colors.white),
            label: construirTexto(
              texto: 'Atualizar Dados',
              tamanhoFonte: 18.0,
              pesoFonte: FontWeight.w500,
              cor: Colors.white,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0097b2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
            label: construirTexto(
              texto: 'Voltar',
              tamanhoFonte: 18.0,
              pesoFonte: FontWeight.w500,
              cor: Colors.white,
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  construirTexto({required texto, cor, tamanhoFonte, pesoFonte}) {
    return Text(
      texto,
      style: GoogleFonts.inter(
        color: cor,
        fontSize: tamanhoFonte,
        fontWeight: pesoFonte,
      ),
    );
  }
}