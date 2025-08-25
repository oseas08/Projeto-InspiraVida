import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  // Variável de estado para controlar a visibilidade da receita
  bool _isRecipeVisible = false;

  // Cores e Estilos para manter a consistência
  static const Color primaryColor = Color(0xFF0A1931);
  static const Color textColor = Color(0xFF333333);

  final TextStyle titleStyle = const TextStyle(
    fontFamily: 'Playfair Display', // Use uma fonte serifada para o título
    fontSize: 32,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.5,
  );

  final TextStyle sectionTitleStyle = const TextStyle(
    fontFamily: 'Playfair Display',
    fontSize: 28,
    color: primaryColor,
    fontWeight: FontWeight.bold,
  );

  final TextStyle bodyTextStyle = TextStyle(
    fontSize: 16,
    color: textColor.withOpacity(0.8),
    height: 1.5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A cor de fundo padrão da tela é branca
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.menu, color: Colors.white),
          ),
        ],
      ),
      // SingleChildScrollView permite que a tela toda role quando o conteúdo for maior
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Parte 1: Conteúdo inicial (Tela 1)
            _buildHeader(),
            _buildDescription(),
            _buildCtaButton(),

            // Parte 2: Conteúdo da receita (Tela 2), que aparece condicionalmente
            if (_isRecipeVisible) _buildRecipeDetails(),
          ],
        ),
      ),
    );
  }

  // Widget para o cabeçalho azul com a imagem
  Widget _buildHeader() {
    return ClipPath(
      clipper: OvalBottomClipper(),
      child: Container(
        width: double.infinity,
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              Text('MOUSSE DE', style: titleStyle),
              Text('CHOCOLATE', style: titleStyle),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                      (index) => const Icon(Icons.star_border, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(height: 20),
              // Certifique-se de ter a imagem em 'assets/mousse.png'

              Image.asset(
                'assets/mousse.png',
                height: 220,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 50), // Espaço para a curva
            ],
          ),
        ),
      ),
    );
  }

  // Widget para o texto de descrição
  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 30, 40, 20),
      child: Text(
        'A mousse de chocolate é uma sobremesa clássica, elegante e irresistivelmente cremosa, perfeita para qualquer ocasião.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.italic,
          color: textColor.withOpacity(0.7),
        ),
      ),
    );
  }

  // Widget para o botão de ação
  Widget _buildCtaButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        // Ao clicar, o estado muda e a receita aparece/desaparece
        onPressed: () {
          setState(() {
            _isRecipeVisible = !_isRecipeVisible;
          });
        },
        child: Text(
          _isRecipeVisible ? 'Ocultar Receita' : 'Visualize receita',
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  // Widget que constrói os detalhes da receita
  Widget _buildRecipeDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('RECEITA DO MOUSSE', style: sectionTitleStyle)),
          const SizedBox(height: 40),

          // Seção de Ingredientes
          _buildSectionHeader('INGREDIENTES', Icons.kitchen_outlined),
          const SizedBox(height: 15),
          _buildListItem('2 latas de creme de leite'),
          _buildListItem('8 colheres de chocolate de sua preferência'),
          _buildListItem('1 lata de leite condensado'),
          _buildListItem('1 pacote de gelatina sem sabor'),
          const SizedBox(height: 40),

          // Seção de Modo de Preparo
          _buildSectionHeader('MODO DE PREPARO', Icons.blender_outlined),
          const SizedBox(height: 15),
          _buildListItem('No liquidificador adicione o creme de leite, leite condensado e o chocolate em pó. Bata por 2 minutos.'),
          _buildListItem('Derreta a gelatina e adicione junto aos ingredientes e bata até misturar.'),
          _buildListItem('Leve à geladeira e deixe até ficar consistente.'),
        ],
      ),
    );
  }

  // Widget auxiliar para os títulos das seções (Ingredientes, etc.)
  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: textColor, size: 24),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  // Widget auxiliar para os itens das listas
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 8),
      child: Text(text, style: bodyTextStyle),
    );
  }
}

// Custom Clipper para criar o efeito da curva no fundo azul
class OvalBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Começa a curva 50px antes do final
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}