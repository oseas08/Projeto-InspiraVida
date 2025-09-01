import 'package:flutter/material.dart';
import 'package:inspiravida/db/comida_dao.dart';
import 'package:inspiravida/widgets/CardComida.dart';

class Cardapio extends StatefulWidget {
  const Cardapio({super.key});

  @override
  State<Cardapio> createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {

  List listaComidas = [];

  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    listaComidas = await ComidaDao().listarComidas();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("OPÇÕES\n DE COMIDA",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
              IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded, size: 40,))
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                    onPressed: (){}, child: Text("Geral", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0A1931)),
                ),
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){}, child: Text("Geral", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0A1931)),
                ),
              ),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){}, child: Text("Geral", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0A1931)),
                ),
              )
            ],
          ),
          SizedBox(height: 50,),
          SizedBox(
            height: 800,
            width: double.infinity,
            child: ListView.builder(
              itemBuilder: (context, i){
                return Cardcomida(comida: listaComidas[i]);
              },
              itemCount: listaComidas.length,
            )
          )
        ],
      ),
    );
  }
}
