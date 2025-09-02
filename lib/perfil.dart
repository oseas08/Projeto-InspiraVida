import 'package:flutter/material.dart';
import 'package:inspiravida/widgets/card_perfil.dart';
import 'db/perfil_dao.dart';
import 'domain/perfil2.dart';

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
                    Image.asset(
                      "assets/personagem.projeto.png",
                      height: 100,
                    ),
                    Text(
                      "Arthur Castro",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("arthurcastro123@gmail.com",
                        style: TextStyle(
                          color: Color(0xFF494949),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
        body: buildBody(),
      ),
    );
  }


  buildBody() {
    return Container(
      padding: EdgeInsets.all(24),
      color: Color(0xFF0097b2),
      child: ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: listaPerfils.length,
              itemBuilder: (context, i) {
                return CardPerfil(perfil: listaPerfils[i]);
              }),
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
                  )),
              child: Text(
                "Salvar",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildPerfil(Perfil2 p) {
    return Container(
      padding: EdgeInsets.all(24),
      color: Color(0xFF0097b2),
      child: ListView(children: [
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
                  Text('')
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
                  Text(p.email,
                      style: TextStyle(
                        fontSize: 18,
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
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.lock_rounded, size: 32),
                SizedBox(width: 10),
                Text(p.senhaantiga,
                    style: TextStyle(
                      fontSize: 18,
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
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                SizedBox(width: 10),
                Icon(Icons.lock, size: 32),
                SizedBox(width: 10),
                Text(p.senhanova,
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ],
            ),
            Row(children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.edit, size: 32)),
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