import 'package:flutter/material.dart';
import 'receita.dart'; // Importa a nossa nova tela de receitas

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receita de Mousse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Fonte padrão para o corpo do texto
      ),
      // A tela inicial agora é o widget que está no arquivo receitas.dart
      home: const RecipeScreen(),
    );
  }
}