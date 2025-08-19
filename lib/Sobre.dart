import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mysql1/mysql1.dart';

class DadosAplicativo {
  final int id;
  final String versao;
  final String dataLancamento;
  final String desenvolvedor;
  final String descricao;
  final int totalUsuarios;
  final String ultimaAtualizacao;

  DadosAplicativo({
    required this.id,
    required this.versao,
    required this.dataLancamento,
    required this.desenvolvedor,
    required this.descricao,
    required this.totalUsuarios,
    required this.ultimaAtualizacao,
  });

  factory DadosAplicativo.fromMap(Map<String, dynamic> map) {
    return DadosAplicativo(
      id: map['id'],
      versao: map['versao'],
      dataLancamento: map['data_lancamento'],
      desenvolvedor: map['desenvolvedor'],
      descricao: map['descricao'],
      totalUsuarios: map['total_usuarios'],
      ultimaAtualizacao: map['ultima_atualizacao'],
    );
  }
}


class DatabaseService {
  static const String _host = 'localhost';
  static const int _port = 3306;
  static const String _user = 'root';
  static const String _password = 'password';
  static const String _database = 'app_database';

  static Future<MySqlConnection> _getConnection() async {
    final settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      password: _password,
      db: _database,
    );
    return await MySqlConnection.connect(settings);
  }

  static Future<DadosAplicativo?> obterDadosAplicativo() async {
    MySqlConnection? conn;
    try {
      conn = await _getConnection();

      var results = await conn.query(
          'SELECT * FROM dados_aplicativo WHERE id = 1'
      );

      if (results.isNotEmpty) {
        var row = results.first;
        return DadosAplicativo.fromMap({
          'id': row[0],
          'versao': row[1],
          'data_lancamento': row[2],
          'desenvolvedor': row[3],
          'descricao': row[4],
          'total_usuarios': row[5],
          'ultima_atualizacao': row[6],
        });
      }
      return null;
    } catch (e) {
      print('Erro ao buscar dados: $e');
      return null;
    } finally {
      await conn?.close();
    }
  }

  static Future<bool> atualizarDadosAplicativo(DadosAplicativo dados) async {
    MySqlConnection? conn;
    try {
      conn = await _getConnection();

      await conn.query(
          '''UPDATE dados_aplicativo 
           SET versao = ?, data_lancamento = ?, desenvolvedor = ?, 
               descricao = ?, total_usuarios = ?, ultima_atualizacao = ?
           WHERE id = 1''',
          [dados.versao, dados.dataLancamento, dados.desenvolvedor,
            dados.descricao, dados.totalUsuarios, dados.ultimaAtualizacao]
      );

      return true;
    } catch (e) {
      print('Erro ao atualizar dados: $e');
      return false;
    } finally {
      await conn?.close();
    }
  }
}

class PaginaSobreAplicativo extends StatefulWidget {
  const PaginaSobreAplicativo({super.key});

  @override
  State<PaginaSobreAplicativo> createState() => _PaginaSobreAplicativoState();
}

class _PaginaSobreAplicativoState extends State<PaginaSobreAplicativo> {
  DadosAplicativo? dadosApp;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    setState(() {
      carregando = true;
    });

    final dados = await DatabaseService.obterDadosAplicativo();

    setState(() {
      dadosApp = dados ?? DadosAplicativo(
        id: 1,
        versao: '1.0.0',
        dataLancamento: '2024-01-15',
        desenvolvedor: 'Seu Nome',
        descricao: 'Aplicativo em desenvolvimento',
        totalUsuarios: 0,
        ultimaAtualizacao: DateTime.now().toString().substring(0, 10),
      );
      carregando = false;
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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            construirCabecalho(),
            SizedBox(height: 40),
            if (carregando)
              Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            else ...[
              construirCardInfo(
                icone: Icons.info,
                titulo: 'Versão',
                valor: dadosApp?.versao ?? 'N/A',
              ),
              SizedBox(height: 16),
              construirCardInfo(
                icone: Icons.calendar_today,
                titulo: 'Data de Lançamento',
                valor: _formatarData(dadosApp?.dataLancamento ?? ''),
              ),
              SizedBox(height: 16),
              construirCardInfo(
                icone: Icons.person,
                titulo: 'Desenvolvedor',
                valor: dadosApp?.desenvolvedor ?? 'N/A',
              ),
              SizedBox(height: 16),
              construirCardInfo(
                icone: Icons.group,
                titulo: 'Total de Usuários',
                valor: '${dadosApp?.totalUsuarios ?? 0}',
              ),
              SizedBox(height: 16),
              construirCardInfo(
                icone: Icons.update,
                titulo: 'Última Atualização',
                valor: _formatarData(dadosApp?.ultimaAtualizacao ?? ''),
              ),
              SizedBox(height: 16),
              construirCardDescricao(),
              SizedBox(height: 30),
              construirBotaoAtualizar(),
              SizedBox(height: 20),
              construirBotaoVoltar(),
            ],
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  construirCabecalho() {
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF0277BD),
          ),
          child: Icon(
            Icons.info,
            size: 40,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        construirTexto(
          texto: 'Sobre o Aplicativo',
          tamanhoFonte: 24.0,
          pesoFonte: FontWeight.w600,
          cor: Colors.white,
        ),
        SizedBox(height: 8),
        construirTexto(
          texto: 'Informações detalhadas do sistema',
          tamanhoFonte: 14.0,
          cor: Colors.white70,
        ),
      ],
    );
  }

  construirCardInfo({
    required IconData icone,
    required String titulo,
    required String valor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icone,
              color: Colors.black54,
              size: 24,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  construirTexto(
                    texto: titulo,
                    tamanhoFonte: 16.0,
                    pesoFonte: FontWeight.w500,
                    cor: Colors.black87,
                  ),
                  SizedBox(height: 4),
                  construirTexto(
                    texto: valor,
                    tamanhoFonte: 14.0,
                    pesoFonte: FontWeight.w400,
                    cor: Colors.black54,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  construirCardDescricao() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.description,
                  color: Colors.black54,
                  size: 24,
                ),
                SizedBox(width: 16),
                construirTexto(
                  texto: 'Descrição',
                  tamanhoFonte: 16.0,
                  pesoFonte: FontWeight.w500,
                  cor: Colors.black87,
                ),
              ],
            ),
            SizedBox(height: 12),
            construirTexto(
              texto: dadosApp?.descricao ?? 'Sem descrição disponível',
              tamanhoFonte: 14.0,
              cor: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  construirBotaoAtualizar() {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: carregarDados,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0097b2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.refresh, color: Colors.white, size: 20),
            SizedBox(width: 8),
            construirTexto(
              texto: 'Atualizar Dados',
              tamanhoFonte: 16.0,
              pesoFonte: FontWeight.w500,
              cor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  construirBotaoVoltar() {
    return Container(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () => Navigator.pop(context),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_back, color: Colors.white, size: 20),
            SizedBox(width: 8),
            construirTexto(
              texto: 'Voltar',
              tamanhoFonte: 16.0,
              pesoFonte: FontWeight.w500,
              cor: Colors.white,
            ),
          ],
        ),
      ),
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

  String _formatarData(String data) {
    if (data.isEmpty) return 'N/A';
    try {
      DateTime dateTime = DateTime.parse(data);
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return data;
    }
  }
}