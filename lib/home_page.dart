import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Sobre.dart';


class PaginaConfiguracoes extends StatefulWidget {
  const PaginaConfiguracoes({super.key});

  @override
  State<PaginaConfiguracoes> createState() => _PaginaConfiguracoesState();
}

class _PaginaConfiguracoesState extends State<PaginaConfiguracoes> {
  bool notificacoesHabilitadas = true;
  bool modoEscuroHabilitado = false;
  bool localizacaoHabilitada = true;

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
            construirCabecalhoConfiguracoes(),
            SizedBox(height: 40),
            construirOpcaoSwitch(
              icone: Icons.notifications,
              titulo: 'Notificações',
              subtitulo: 'Receber notificações',
              valor: notificacoesHabilitadas,
              aoMudar: (valor) {
                setState(() {
                  notificacoesHabilitadas = valor;
                });
              },
            ),
            SizedBox(height: 16),
            construirOpcaoSwitch(
              icone: Icons.dark_mode,
              titulo: 'Modo Escuro',
              subtitulo: 'Ativar tema escuro',
              valor: modoEscuroHabilitado,
              aoMudar: (valor) {
                setState(() {
                  modoEscuroHabilitado = valor;
                });
              },
            ),
            SizedBox(height: 16),
            construirOpcaoSwitch(
              icone: Icons.location_on,
              titulo: 'Localização',
              subtitulo: 'Permitir acesso à localização',
              valor: localizacaoHabilitada,
              aoMudar: (valor) {
                setState(() {
                  localizacaoHabilitada = valor;
                });
              },
            ),
            SizedBox(height: 16),
            construirCampoOpcao(
              icone: Icons.language,
              titulo: 'Idioma',
              subtitulo: 'Português (Brasil)',
              aoToque: () {
                // Implementar navegação para seleção de idioma
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Função em desenvolvimento')),
                );
              },
            ),
            SizedBox(height: 16),
            construirCampoOpcao(
              icone: Icons.privacy_tip,
              titulo: 'Privacidade',
              subtitulo: 'Configurações de privacidade',
              aoToque: () {
                // Implementar navegação para privacidade
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Função em desenvolvimento')),
                );
              },
            ),
            SizedBox(height: 16),
            construirCampoOpcao(
              icone: Icons.security,
              titulo: 'Segurança',
              subtitulo: 'Autenticação e senha',
              aoToque: () {
                // Implementar navegação para segurança
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Função em desenvolvimento')),
                );
              },
            ),
            SizedBox(height: 16),
            construirCampoOpcao(
              icone: Icons.help,
              titulo: 'Ajuda',
              subtitulo: 'Central de ajuda e suporte',
              aoToque: () {
                // Implementar navegação para ajuda
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Função em desenvolvimento')),
                );
              },
            ),
            SizedBox(height: 16),
            construirCampoOpcao(
              icone: Icons.info,
              titulo: 'Sobre',
              subtitulo: 'Informações do aplicativo',
              aoToque: () {
                // Navegar para a tela sobre o aplicativo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaSobreAplicativo(),
                  ),
                );
              },
            ),
            SizedBox(height: 60),
            construirBotaoLogout(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  construirCabecalhoConfiguracoes() {
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
            Icons.settings,
            size: 40,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 16),
        construirTexto(
          texto: 'Configurações',
          tamanhoFonte: 24.0,
          pesoFonte: FontWeight.w600,
          cor: Colors.white,
        ),
        SizedBox(height: 8),
        construirTexto(
          texto: 'Personalize sua experiência',
          tamanhoFonte: 14.0,
          cor: Colors.white70,
        ),
      ],
    );
  }

  construirOpcaoSwitch({
    required IconData icone,
    required String titulo,
    required String subtitulo,
    required bool valor,
    required Function(bool) aoMudar,
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
                    texto: subtitulo,
                    tamanhoFonte: 14.0,
                    cor: Colors.black54,
                  ),
                ],
              ),
            ),
            Switch(
              value: valor,
              onChanged: aoMudar,
              activeColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  construirCampoOpcao({
    required IconData icone,
    required String titulo,
    required String subtitulo,
    VoidCallback? aoToque,
  }) {
    return InkWell(
      onTap: aoToque,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
                      texto: subtitulo,
                      tamanhoFonte: 14.0,
                      cor: Colors.black54,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.black54,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  construirBotaoLogout() {
    return Container(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          // Implementar logout
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirmar Logout'),
                content: Text('Deseja realmente sair da conta?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Aqui você implementaria a lógica de logout
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Logout realizado')),
                      );
                    },
                    child: Text('Sair'),
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF0097b2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: construirTexto(
          texto: 'Sair da Conta',
          tamanhoFonte: 18.0,
          pesoFonte: FontWeight.w500,
          cor: Colors.white,
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
}