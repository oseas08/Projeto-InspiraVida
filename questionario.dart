import 'package:flutter/material.dart';


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
  String? idade;
  String? genero;
  String? fumante;


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
                  const Text(
                    'Questionário',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
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
                      title: 'Idade',
                      children: [
                        buildRadio('Menor de 18 anos', idade, (val) => setState(() => idade = val)),
                        buildRadio('Entre 18 a 29 anos', idade, (val) => setState(() => idade = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Gênero',
                      children: [
                        buildRadio('Feminino', genero, (val) => setState(() => genero = val)),
                        buildRadio('Masculino', genero, (val) => setState(() => genero = val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildCard(
                      title: 'Fuma atualmente?',
                      children: [
                        buildRadio('Sim, diariamente', fumante, (val) => setState(() => fumante = val)),
                        buildRadio('Sim, ocasionalmente', fumante, (val) => setState(() => fumante = val)),
                        buildRadio('Não, parei de fumar', fumante, (val) => setState(() => fumante = val)),
                        buildRadio('Nunca fumei', fumante, (val) => setState(() => fumante = val)),
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
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }


  Widget buildRadio(String label, String? groupValue, ValueChanged<String?> onChanged) {
    return RadioListTile<String>(
      title: Text(label),
      value: label,
      groupValue: groupValue,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
    );
  }
}
