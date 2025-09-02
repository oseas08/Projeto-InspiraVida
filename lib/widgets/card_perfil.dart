import 'package:flutter/material.dart';
import '../domain/perfil2.dart';

class CardPerfil extends StatefulWidget {
  final Perfil2 perfil;

  const CardPerfil({Key? key, required this.perfil}) : super(key: key);

  @override
  State<CardPerfil> createState() => _CardPerfilState();
}

class _CardPerfilState extends State<CardPerfil> {
  Perfil2 get perfil => widget.perfil;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: Color(0xFF0097b2),
      child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.person, size: 32),
                      SizedBox(width: 10),
                      Text(perfil.nome,
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    ],
                  ),
                  Row(children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
                    SizedBox(width: 10)
                  ]),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.email, size: 32),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(perfil.email,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
                  SizedBox(width: 10)
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.lock_rounded, size: 32),
                        SizedBox(width: 10),
                        Text(perfil.senhaantiga,
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    Row(children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
                      SizedBox(width: 10)
                    ]),
                  ]),
            ),
            Container(
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.lock, size: 32),
                        SizedBox(width: 10),
                        Text(perfil.senhanova,
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ],
                    ),
                    Row(children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
                      SizedBox(width: 10)
                    ]),
                  ]),
            ),
            SizedBox(
              height: 100,
            ),
          ]),
    );
  }
}
