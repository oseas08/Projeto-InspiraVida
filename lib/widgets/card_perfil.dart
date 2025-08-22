import 'package:flutter/material.dart';
import '../domain/perfil.dart';


class CardPerfil extends StatefulWidget {
  Perfil perfil;

  CardPerfil({
    required this.perfil,
    super.key,
  });

  @override
  State<CardPerfil> createState() => _CardPerfilState();
}

class _CardPerfilState extends State<CardPerfil> {
  Perfil get perfil => widget.perfil;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      color: Color(0xFF0097b2),
      child: ListView(
          children: [
            Container(
              height: 40,
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
                  Row(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
                        SizedBox(width: 10)
                      ]),
                ],
              ),
            ),
            Container(
              height: 40,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.email, size: 32),
                      SizedBox(width: 10),
                      Text(perfil.email,
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    ],
                  ),
                  Row(children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
                    SizedBox(width: 10)
                  ])
                ],
              ),
            ),
            Container(
              height: 40,
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
              height: 40,
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
                    ]
                    ),
                  ]),
            ),
            SizedBox(
              height: 100,
            ),
          ]
      ),
    );
  }
}