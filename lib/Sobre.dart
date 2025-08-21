import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_helper;

class DadosApp {
  String versao;
  String dataLancamento;
  String desenvolvedor;
  String descricao;

  DadosApp({
    required this.versao,
    required this.dataLancamento,
    required this.desenvolvedor,
    required this.descricao,
  });
}


class BancoDados {
  static Database? _banco;

  static Future<Database> _abrirBanco() async {
    if (_banco != null) return _banco!;

    String caminho = path_helper.join(await getDatabasesPath(), 'app.db');

    _banco = await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) {

        db.execute('''
          CREATE TABLE app_info (
            id INTEGER PRIMARY KEY,
            versao TEXT,
            data_lancamento TEXT,
            desenvolvedor TEXT,
            descricao TEXT
          )
        ''');


        db.insert('app_info', {
          'id': 1,
          'versao': '1.0.0',
          'data_lancamento': '15/01/2024',
          'desenvolvedor': 'Seu Nome Aqui',
          'descricao': 'Este é um aplicativo simples feito em Flutter com banco SQLite.'
        });
      },
    );

    return _banco!;
  }


  static Future<DadosApp> buscarDados() async {
    final db = await _abrirBanco();
    final resultado = await db.query('app_info', where: 'id = ?', whereArgs: [1]);

    if (resultado.isNotEmpty) {
      final dados = resultado.first;
      return DadosApp(
        versao: dados['versao'] as String,
        dataLancamento: dados['data_lancamento'] as String,
        desenvolvedor: dados['desenvolvedor'] as String,
        descricao: dados['descricao'] as String,
      );
    }


    return DadosApp(
      versao: '1.0.0',
      dataLancamento: '15/01/2024',
      desenvolvedor: 'Desenvolvedor',
      descricao: 'Aplicativo Flutter com SQLite',
    );
  }


  static Future<void> salvarDescricao(String novaDescricao) async {
    final db = await _abrirBanco();
    await db.update(
      'app_info',
      {'descricao': novaDescricao},
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}

class PaginaSobre extends StatefulWidget {
  const PaginaSobre({super.key});

  @override
  State<PaginaSobre> createState() => _PaginaSobreState();
}

class _PaginaSobreState extends State<PaginaSobre> {
  DadosApp? dados;
  bool carregando = true;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future<void> _carregarDados() async {
    final dadosDoBanco = await BancoDados.buscarDados();
    if (mounted) {
      setState(() {
        dados = dadosDoBanco;
        carregando = false;
      });
    }
  }


  Future<void> _atualizarDescricao(String novaDescricao) async {
    try {
      await BancoDados.salvarDescricao(novaDescricao);
      await _carregarDados();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Descrição salva!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF123870),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _construirCabecalho(),
              const SizedBox(height: 40),

              if (carregando)
                const CircularProgressIndicator(color: Colors.white)
              else ...[
                _construirCard('Versão', dados!.versao, Icons.info),
                const SizedBox(height: 16),
                _construirCard('Data de Lançamento', dados!.dataLancamento, Icons.calendar_today),
                const SizedBox(height: 16),
                _construirCard('Desenvolvedor', dados!.desenvolvedor, Icons.person),
                const SizedBox(height: 16),
                _construirCardDescricao(),
                const SizedBox(height: 30),
                _construirBotaoVoltar(),
              ],

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _construirCabecalho() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF0277BD),
          ),
          child: const Icon(Icons.info, size: 40, color: Colors.white),
        ),
        const SizedBox(height: 16),
        _construirTexto('Sobre o App', 24.0, FontWeight.w600, Colors.white),
        const SizedBox(height: 8),
        _construirTexto('Dados salvos no SQLite', 14.0, FontWeight.normal, Colors.white70),
      ],
    );
  }

  Widget _construirCard(String titulo, String valor, IconData icone) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icone, color: Colors.black54, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _construirTexto(titulo, 16.0, FontWeight.w500, Colors.black87),
                const SizedBox(height: 4),
                _construirTexto(valor, 14.0, FontWeight.normal, Colors.black54),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirCardDescricao() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description, color: Colors.black54, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: _construirTexto('Descrição', 16.0, FontWeight.w500, Colors.black87),
              ),
              IconButton(
                onPressed: _mostrarDialogEdicao,
                icon: const Icon(Icons.edit, color: Color(0xFF0277BD), size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _construirTexto(dados?.descricao ?? '', 14.0, FontWeight.normal, Colors.black54),
        ],
      ),
    );
  }

  void _mostrarDialogEdicao() {
    _controller.text = dados?.descricao ?? '';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Editar Descrição'),
        content: TextField(
          controller: _controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Digite a nova descrição...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              if (_controller.text.trim().isNotEmpty) {
                _atualizarDescricao(_controller.text.trim());
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0277BD)),
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _construirBotaoVoltar() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () => Navigator.pop(context),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            _construirTexto('Voltar', 16.0, FontWeight.w500, Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _construirTexto(String texto, double tamanho, FontWeight peso, Color cor) {
    return Text(
      texto,
      style: GoogleFonts.inter(
        fontSize: tamanho,
        fontWeight: peso,
        color: cor,
      ),
    );
  }
}