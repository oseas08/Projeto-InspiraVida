import 'package:flutter/material.dart';
import 'package:inspiravida/api/comida_api.dart';
import 'package:inspiravida/domain/Comida.dart';
import 'package:inspiravida/domain/Comida_api_verdadeira.dart';
import 'package:inspiravida/widgets/CardComida.dart';

class Cardapio extends StatefulWidget {
  const Cardapio({super.key});

  @override
  State<Cardapio> createState() => _CardapioState();
}

class _CardapioState extends State<Cardapio> {
  late Future<List<Comida>> listaComidas;
  late Future<List<Items>> listaItems;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    listaComidas = ComidaApiFake().getAll();
    listaItems = ComidaApi().getAll();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "OPÇÕES\n DE COMIDA",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search_rounded, size: 40),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFilterButton("Geral"),
              _buildFilterButton("Fitness"),
              _buildFilterButton("Caseiras"),
            ],
          ),
          SizedBox(height: 30),
          Text(
            "Comidas Locais",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 400,
            child: FutureBuilder<List<Comida>>(
              future: listaComidas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Nenhum prato encontrado."));
                }

                List<Comida> lista = snapshot.data!;
                return buildHorizontalList(lista);
              },
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Pratos da Api real",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 400,
            child: FutureBuilder<List<Items>>(
              future: listaItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erro: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Nenhum prato encontrado."));
                }

                List<Items> lista = snapshot.data!;
                return buildHorizontalList(lista);
              },
            ),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget buildHorizontalList(List<dynamic> lista) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: lista.map((item) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Cardcomida(comida: item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A1931),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
