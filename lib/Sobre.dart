import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_helper;
import 'PaginaPerfil.dart';


class DadosApp {
  String versao;
  String dataLancamento;
  String desenvolvedores;
  String descricao;

  DadosApp({
    required this.versao,
    required this.dataLancamento,
    required this.desenvolvedores,
    required this.descricao,
  });
}

class BancoDados {
  static Database? _banco;

  static Future<Database> _abrirBanco() async {
    if (_banco != null) return _banco!;

    String caminho = path_helper.join(await getDatabasesPath(), 'app.db');
    await deleteDatabase(caminho);

    _banco = await openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) async {
        print('Criando banco de dados...');

        await db.execute('''
          CREATE TABLE app_info (
            id INTEGER PRIMARY KEY,
            versao TEXT,
            data_lancamento TEXT,
            desenvolvedores TEXT,
            descricao TEXT
          )
        ''');

        await db.insert('app_info', {
          'id': 1,
          'versao': '1.0.0',
          'data_lancamento': '15/01/2024',
          'desenvolvedores': 'Seu Nome Aqui',
          'descricao': 'Este é um aplicativo simples feito em Flutter com banco SQLite.'
        });

        print('Dados iniciais criados');
      },
    );

    return _banco!;
  }

  static Future<DadosApp> buscarDados() async {
    try {
      final db = await _abrirBanco();
      final resultado = await db.query('app_info', where: 'id = ?', whereArgs: [1]);

      if (resultado.isNotEmpty) {
        final dados = resultado.first;
        return DadosApp(
          versao: dados['versao'] as String,
          dataLancamento: dados['data_lancamento'] as String,
          desenvolvedores: dados['desenvolvedores'] as String,
          descricao: dados['descricao'] as String,
        );
      }

      await _criarDadosPadrao();
      return DadosApp(
        versao: '1.0.0',
        dataLancamento: '15/01/2024',
        desenvolvedores: 'Desenvolvedor',
        descricao: 'Aplicativo Flutter com SQLite',
      );
    } catch (e) {
      print('Erro ao buscar dados: $e');
      rethrow;
    }
  }

  static Future<void> _criarDadosPadrao() async {
    final db = await _abrirBanco();
    await db.insert('app_info', {
      'id': 1,
      'versao': '1.0.0',
      'data_lancamento': '15/01/2024',
      'desenvolvedores': 'Desenvolvedor',
      'descricao': 'Aplicativo Flutter com SQLite',
    });
  }

  static Future<void> salvarDescricao(String novaDescricao) async {
    try {
      final db = await _abrirBanco();

      final resultado = await db.query('app_info', where: 'id = ?', whereArgs: [1]);

      if (resultado.isEmpty) {
        await _criarDadosPadrao();
      }

      await db.update(
        'app_info',
        {'descricao': novaDescricao},
        where: 'id = ?',
        whereArgs: [1],
      );

      print('Descrição salva: $novaDescricao');

    } catch (e) {
      print('Erro ao salvar: $e');
      rethrow;
    }
  }

  static Future<void> salvarDesenvolvedores(String desenvolvedores) async {
    try {
      final db = await _abrirBanco();

      final resultado = await db.query('app_info', where: 'id = ?', whereArgs: [1]);

      if (resultado.isEmpty) {
        await _criarDadosPadrao();
      }

      await db.update(
        'app_info',
        {'desenvolvedores': desenvolvedores},
        where: 'id = ?',
        whereArgs: [1],
      );

      print('Desenvolvedores salvos: $desenvolvedores');

    } catch (e) {
      print('Erro ao salvar desenvolvedores: $e');
      rethrow;
    }
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
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _desenvolvedoresController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _desenvolvedoresController.dispose();
    super.dispose();
  }

  Future<void> _carregarDados() async {
    try {
      setState(() => carregando = true);

      final dadosDoBanco = await BancoDados.buscarDados();

      if (mounted) {
        setState(() {
          dados = dadosDoBanco;
          carregando = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => carregando = false);
        _mostrarMensagem('Erro ao carregar dados: $e', isError: true);
      }
    }
  }

  Future<void> _atualizarDescricao(String novaDescricao) async {
    try {
      await BancoDados.salvarDescricao(novaDescricao);

      if (mounted && dados != null) {
        setState(() {
          dados!.descricao = novaDescricao;
        });
        _mostrarMensagem('Descrição salva com sucesso!');
      }
    } catch (e) {
      if (mounted) {
        _mostrarMensagem('Erro ao salvar: $e', isError: true);
      }
    }
  }

  Future<void> _atualizarDesenvolvedores(String desenvolvedores) async {
    try {
      await BancoDados.salvarDesenvolvedores(desenvolvedores);

      if (mounted && dados != null) {
        setState(() {
          dados!.desenvolvedores = desenvolvedores;
        });
        _mostrarMensagem('Desenvolvedores salvos com sucesso!');
      }
    } catch (e) {
      if (mounted) {
        _mostrarMensagem('Erro ao salvar desenvolvedores: $e', isError: true);
      }
    }
  }

  void _mostrarMensagem(String mensagem, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF123870),
        body: construirCorpo(),
      ),
    );
  }

  construirCorpo() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            construirCabecalhoSobre(),
            const SizedBox(height: 40),

            if (carregando)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            else ...[
              _criarCard('Versão', dados?.versao ?? '', Icons.info),
              const SizedBox(height: 16),

              _criarCard('Data de Lançamento', dados?.dataLancamento ?? '', Icons.calendar_today),
              const SizedBox(height: 16),

              _criarCardEditavel('Desenvolvedores', dados?.desenvolvedores ?? '', Icons.person, _abrirDialogEdicaoDesenvolvedores),
              const SizedBox(height: 16),

              _criarCardEditavel('Descrição', dados?.descricao ?? '', Icons.description, _abrirDialogEdicaoDescricao),

              const SizedBox(height: 40),

              construirBotaoConfiguracoes(),
              const SizedBox(height: 40),
            ],
          ],
        ),
      ),
    );
  }

  construirCabecalhoSobre() {
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
          child: const Icon(
            Icons.info,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Sobre o App',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Informações do aplicativo',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _criarCard(String titulo, String valor, IconData icone) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icone,
              color: Colors.black54,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    valor,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _criarCardEditavel(String titulo, String valor, IconData icone, VoidCallback onEdit) {
    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icone,
                color: Colors.black54,
                size: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      valor,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.edit,
                color: Colors.black54,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  construirBotaoConfiguracoes() {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context); // Volta para a tela anterior (configurações)
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0097b2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Voltar às Configurações',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _abrirDialogEdicaoDescricao() {
    _descricaoController.text = dados?.descricao ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Descrição'),
        content: TextField(
          controller: _descricaoController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Digite a nova descrição...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              final texto = _descricaoController.text.trim();
              if (texto.isNotEmpty) {
                _atualizarDescricao(texto);
              } else {
                _mostrarMensagem('Descrição não pode estar vazia', isError: true);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _abrirDialogEdicaoDesenvolvedores() {
    _desenvolvedoresController.text = dados?.desenvolvedores ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Desenvolvedores'),
        content: TextField(
          controller: _desenvolvedoresController,
          maxLines: 2,
          decoration: const InputDecoration(
            hintText: 'Ex: João Silva, Maria Santos, Pedro Costa',
            labelText: 'Desenvolvedores (separados por vírgula)',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              final texto = _desenvolvedoresController.text.trim();
              if (texto.isNotEmpty) {
                _atualizarDesenvolvedores(texto);
              } else {
                _mostrarMensagem('Campo desenvolvedores não pode estar vazio', isError: true);
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

  }
}