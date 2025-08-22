import 'package:flutter/material.dart';
import 'package:inspiravida/widgets/card_perfil.dart';

import 'db/perfil_dao.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  List listaPerfils = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    listaPerfils = await PerfilDao().listarPerfil();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF49d3ee),
          toolbarHeight: 280,
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
                  height: 30,
                ),
                Column(
                  children: [
                    Image.asset("assets/personagem.projeto.png", height: 100,),
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
          child: ListView(
              children: [
          ListView.builder(
          itemCount: listaPerfils.length,
              itemBuilder: (context, i) {
                return CardPerfil(
                  perfil: listaPerfils[i],
                );
              },
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