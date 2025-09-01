import 'package:flutter/material.dart';

import '../domain/Comida.dart';

class Cardcomida extends StatefulWidget {

  Comida comida;

  Cardcomida({super.key, required this.comida});

  @override
  State<Cardcomida> createState() => _CardcomidaState();
}

class _CardcomidaState extends State<Cardcomida> {

  Comida get comida => widget.comida;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 350,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: Color(0xFFd3e0ed),width: 2.0)),
      child: Column(
        children: [
          Image.asset(comida.pathImage),
          Text(comida.nome),
          Text(comida.descricao)
        ],
      ),

    );
  }
}
