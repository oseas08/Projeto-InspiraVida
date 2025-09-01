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
      padding: EdgeInsets.symmetric(horizontal: 5),
      width: 200,
      height: 400,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Color(0xFFd3e0ed),width: 2.0)),
      child: Column(
        children: [
          Image.asset(comida.pathImage),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(comida.nome, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
            ],
          ),
          Text(comida.descricao)
        ],
      ),

    );
  }
}
