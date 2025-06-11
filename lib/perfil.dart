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
          toolbarHeight: 350,
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
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Image.asset("assets/personagem.projeto.png", height: 150,),
                    Text("Arthur Castro", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 10,),
                    Text("arthurcastro123@gmail.com", style: TextStyle(
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
                          Text("Arthur Castro",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                      Row(children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
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
                          Text("arthurcastro123@gmail.com",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                      Row(children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
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
                            Text("Senha antiga",
                                style: TextStyle(
                                  fontSize: 22,
                                )),
                          ],
                        ),
                        Row(children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
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
                            Text("Nova senha",
                                style: TextStyle(
                                  fontSize: 22,
                                )),
                          ],
                        ),
                        Row(children: [
                          IconButton( onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
                          SizedBox(width: 10)
                        ]
                          ),
                      ]),
                ),
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(left: 10, right: 12), 
                      backgroundColor: Color(0xFF49d3ee),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    child: Text("Salvar",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ]
                ),
        ),
      ),
    );
  }
}
