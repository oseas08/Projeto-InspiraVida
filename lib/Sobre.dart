import 'package:flutter/material.dart';
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
      onCreate: (db, version) async {
        print('Criando banco de dados...');
        
        await db.execute('''
          CREATE TABLE app_info (
            id INTEGER PRIMARY KEY,
            versao TEXT,
            data_lancamento TEXT,
            desenvolvedor TEXT,
            descricao TEXT
          )
        ''');

        await db.insert('app_info', {
          'id': 1,
          'versao': '1.0.0',
          'data_lancamento': '15/01/2024',
          'desenvolvedor': 'Seu Nome Aqui',
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
          desenvolvedor: dados['desenvolvedor'] as String,
          descricao: dados['descricao'] as String,
        );
      }

      await _criarDadosPadrao();
      return DadosApp(
        versao: '1.0.0',
        dataLancamento: '15/01/2024',
        desenvolvedor: 'Desenvolvedor',
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
      'desenvolvedor': 'Desenvolvedor',
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
      await _carregarDados();
      
      if (mounted) {
        _mostrarMensagem('Descrição salva com sucesso!');
      }
    } catch (e) {
      if (mounted) {
        _mostrarMensagem('Erro ao salvar: $e', isError: true);
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
    return Scaffold(
      backgroundColor: const Color(0xFF123870),
      appBar: AppBar(
        backgroundColor: const Color(0xFF123870),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          'Sobre o App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: carregando 
        ? const Center(
            child: CircularProgressIndicator(color: Colors.white),
          )
        : SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0277BD),
                  ),
                  child: const Icon(Icons.info, size: 40, color: Colors.white),
                ),
                
                const SizedBox(height: 20),
                
                const Text(
                  'Informações do App',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                _criarCard('Versão', dados?.versao ?? '', Icons.info),
                const SizedBox(height: 15),
                
                _criarCard('Data de Lançamento', dados?.dataLancamento ?? '', Icons.calendar_today),
                const SizedBox(height: 15),
                
                _criarCard('Desenvolvedor', dados?.desenvolvedor ?? '', Icons.person),
                const SizedBox(height: 15),
                
                _criarCardDescricao(),
                
                const SizedBox(height: 30),
                
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: _carregarDados,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Recarregar Dados'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0277BD),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _criarCard(String titulo, String valor, IconData icone) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icone, color: const Color(0xFF123870), size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF123870),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _criarCardDescricao() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.description, color: Color(0xFF123870), size: 24),
              const SizedBox(width: 15),
              const Expanded(
                child: Text(
                  'Descrição',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF123870),
                  ),
                ),
              ),
              IconButton(
                onPressed: _abrirDialogEdicao,
                icon: const Icon(Icons.edit, color: Color(0xFF0277BD), size: 20),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            dados?.descricao ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _abrirDialogEdicao() {
    _controller.text = dados?.descricao ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              final texto = _controller.text.trim();
              if (texto.isNotEmpty) {
                _atualizarDescricao(texto);
              } else {
                _mostrarMensagem('Descrição não pode estar vazia', isError: true);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0277BD),
            ),
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
