import 'package:flutter/material.dart';
import '../db/receita_dao.dart';
import '../domain/receita.dart';
import '../widgets/card_receita.dart';


class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List listarReceitas = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    listarReceitas = await ReceitasDao().listarReceitas();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      // FOR
      child: ListView.builder(
        // children: [
        // for(int i = 0; i < propriedades.length; i++) {
        //   CardPropriedade(
        //     propriedade: propriedades[i],
        //   )
        // }
        itemCount: listarReceitas.length,
        itemBuilder: (context, i) {
          return CardReceita(
            receita: listarReceitas[i],
          );
        },

        // ],
      ),
    );
  }
}