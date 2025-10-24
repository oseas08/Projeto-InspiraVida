import 'package:flutter/material.dart';
import 'package:inspiravida/db/comida_dao.dart';
import 'package:inspiravida/domain/Comida.dart';
import 'package:inspiravida/widgets/CardComida.dart';

import '../api/comida_api.dart';

class Cardapio extends StatefulWidget {
  const Cardapio({super.key});

  @override
  State<Cardapio> createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {

  late Future<List<Comida>> listaComidas;


  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    listaComidas = ComidaApi().getAll();
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
                  onPressed: (){}, child: Text("Fitness", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0A1931)),
                ),
              ),
              SizedBox(
                width: 110,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){}, child: Text("Caseiras", style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0A1931)),
                ),
              )
            ],
          ),
          SizedBox(height: 50,),
          SizedBox(
            height: 700,
            width: double.infinity,
            child: FutureBuilder<List<Comida>>(
              future: listaComidas,
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  List<Comida> lista = snapshot.requireData;
                  return buildGridView(lista);
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SizedBox(height: 100,)
        ],
      ),
    );
  }

  buildGridView(List<Comida> listaComidas){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 5,
          childAspectRatio: 0.8
      ),
      itemBuilder: (context, i){
        return Cardcomida(comida: listaComidas[i]);
      },
      itemCount: listaComidas.length,);
  }
}
