import 'ficha.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: QuestionarioPage(),
  ));
}

class QuestionarioPage extends StatefulWidget {
  const QuestionarioPage({Key? key}) : super(key: key);

  @override
  State<QuestionarioPage> createState() => _QuestionarioPageState();
}

class _QuestionarioPageState extends State<QuestionarioPage> {
  String? tempoPrimeiroCigarro;
  String? locaisProibidos;
  String? qtdCigarros;
  String? fumaPelaManha;
  String? fumaDoente;
  String? idadeFumo;
  String? genero;
  String? atividadeFisica;
  String? alimentacao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0097b2),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFF5ce1e6),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  construirTexto(
                    texto: 'Questionário',
                    cor: Colors.black87,
                    tamanhoFonte: 20,
                    pesoFonte: FontWeight.w500,
                  ),
                  const Spacer(),
                  SizedBox(width: 40),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildCard(
                      title: 'Em quanto tempo depois de acordar você fuma o primeiro cigarro?',
                      children: [
                        buildRadio('Dentro de 5 min', tempoPrimeiroCigarro, (val) => setState(() => tempoPrimeiroCigarro = val)),
                        buildRadio('6-30 min', tempoPrimeiroCigarro, (val) => setState(() => tempoPrimeiroCigarro = val)),
                        buildRadio('31-60 min', tempoPrimeiroCigarro, (val) => setState(() => tempoPrimeiroCigarro = val)),
                        buildRadio('Depois de 60 min', tempoPrimeiroCigarro, (val) => setState(() => tempoPrimeiroCigarro = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Você acha difícil ficar sem fumar em lugares onde é proibido?',
                      children: [
                        buildRadio('Sim', locaisProibidos, (val) => setState(() => locaisProibidos = val)),
                        buildRadio('Não', locaisProibidos, (val) => setState(() => locaisProibidos = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Quantos cigarros você fuma por dia?',
                      children: [
                        buildRadio('Menos de 10', qtdCigarros, (val) => setState(() => qtdCigarros = val)),
                        buildRadio('De 11 a 20', qtdCigarros, (val) => setState(() => qtdCigarros = val)),
                        buildRadio('De 21 a 30', qtdCigarros, (val) => setState(() => qtdCigarros = val)),
                        buildRadio('Mais de 31', qtdCigarros, (val) => setState(() => qtdCigarros = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Você fuma mais frequentemente pela manhã?',
                      children: [
                        buildRadio('Sim', fumaPelaManha, (val) => setState(() => fumaPelaManha = val)),
                        buildRadio('Não', fumaPelaManha, (val) => setState(() => fumaPelaManha = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Você fuma mesmo doente quando precisa ficar na cama a maior parte do tempo?',
                      children: [
                        buildRadio('Sim', fumaDoente, (val) => setState(() => fumaDoente = val)),
                        buildRadio('Não', fumaDoente, (val) => setState(() => fumaDoente = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Com qual idade começou a fumar?',
                      children: [
                        buildRadio('Menor de 15 anos', idadeFumo, (val) => setState(() => idadeFumo = val)),
                        buildRadio('Entre 18 a 29+', idadeFumo, (val) => setState(() => idadeFumo = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Gênero:',
                      children: [
                        buildRadio('Masculino', genero, (val) => setState(() => genero = val)),
                        buildRadio('Feminino', genero, (val) => setState(() => genero = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Pratica atividades físicas?',
                      children: [
                        buildRadio('Algumas vezes na semana…', atividadeFisica, (val) => setState(() => atividadeFisica = val)),
                        buildRadio('Raramente', atividadeFisica, (val) => setState(() => atividadeFisica = val)),
                        buildRadio('Todos os dias!!', atividadeFisica, (val) => setState(() => atividadeFisica = val)),
                        buildRadio('Nunca!', atividadeFisica, (val) => setState(() => atividadeFisica = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Alimentação do dia:',
                      children: [
                        buildRadio('Equilibrada e variada', alimentacao, (val) => setState(() => alimentacao = val)),
                        buildRadio('Pouco saudável', alimentacao, (val) => setState(() => alimentacao = val)),
                        buildRadio('Regulada', alimentacao, (val) => setState(() => alimentacao = val)),
                        buildRadio('Só me alimento de lanche e fumo', alimentacao, (val) => setState(() => alimentacao = val)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard({required String title, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF117bab),
              borderRadius: BorderRadius.circular(8),
            ),
            child: construirTexto(
              texto: title,
              cor: Colors.white,
              tamanhoFonte: 16,
              pesoFonte: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...children,
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Ficha(
                  ),
                ),
              );
            },
            child: Text("Próximo"),
          ),

        ],
      ),
    );
  }



  Widget buildRadio(String label, String? groupValue, ValueChanged<String?> onChanged) {
    return RadioListTile<String>(
      title: construirTexto(
        texto: label,
        cor: Colors.black,
        tamanhoFonte: 14,
        pesoFonte: FontWeight.normal,
      ),
      value: label,
      groupValue: groupValue,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}

Widget construirTexto({
  required String texto,
  required Color cor,
  required double tamanhoFonte,
  required FontWeight pesoFonte,
}) {
  return Text(
    texto,
    style: GoogleFonts.inter(
      color: cor,
      fontSize: tamanhoFonte,
      fontWeight: pesoFonte,
    ),
  );
}
