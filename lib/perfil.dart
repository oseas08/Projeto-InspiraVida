import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF49d3ee),
          toolbarHeight: 300,
          flexibleSpace: Padding(
            padding: EdgeInsets.all(8),
            child: Column(

              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
                    Text(
                      "Perfil",
                    )
                  ],
                ),
                Column(
                  children: [
                    Image.asset("assets/personagem.projeto-semfundo.png", height: 150,),
                    Text("Jack Willson", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 10,),
                    Text("jackwillson123@gmail.com", style: TextStyle(
                        color: Color(0xFF494949),)
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          color: Color(0xFF0097b2),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(Icons.person, size: 32),
                          SizedBox(width: 10),
                          Text("Jack Willson",
                              style: TextStyle(
                                fontSize: 24,
                              )),
                        ],
                      ),
                      Row(children: [
                        Icon(Icons.edit, size: 32),
                        SizedBox(width: 10)
                      ]),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(Icons.email, size: 32),
                          SizedBox(width: 10),
                          Text("jackwillson123@gmail.com",
                              style: TextStyle(
                                fontSize: 22,
                              )),
                        ],
                      ),
                      Row(children: [
                        Icon(Icons.edit, size: 32),
                        SizedBox(width: 10)
                      ])
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.lock_rounded, size: 32),
                            SizedBox(width: 10),
                            Text("Senha antiga",
                                style: TextStyle(
                                  fontSize: 22,
                                )),
                          ],
                        ),
                        Row(children: [
                          Icon(Icons.edit, size: 32),
                          SizedBox(width: 10)
                        ]),
                      ]),
                ),
                Container(
                  height: 50,
                  color: Colors.white,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.lock, size: 32),
                            SizedBox(width: 10),
                            Text("Nova senha",
                                style: TextStyle(
                                  fontSize: 22,
                                )),
                          ],
                        ),
                        Row(children: [
                          Icon(Icons.edit, size: 32),
                          SizedBox(width: 10)
                        ]),
                      ]),
                ),
                SizedBox(
                  height: 200,
                )
              ]),
        ),
      ),
    );
  }
}
