import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspiravida/api/exercicio_api.dart';
import 'package:inspiravida/exercicio.dart';

class ExercicioPageFake extends StatefulWidget {
  const ExercicioPageFake({super.key});

  @override
  State<ExercicioPageFake> createState() => _ExercicioPageFakeState();
}

class _ExercicioPageFakeState extends State<ExercicioPageFake> {
  late Future<List<Exercicio>> futureExerciciosFake;

  @override
  void initState() {
    super.initState();
    futureExerciciosFake = ExercicioApi().findExerciciosFake();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppbar(),
        body: FutureBuilder(
          future: futureExerciciosFake,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Um erro aconteceu!"));
            }

            if (snapshot.hasData) {
              List<Exercicio> exercicios = snapshot.requireData;
              return ListView.builder(
                itemCount: exercicios.length,
                itemBuilder: (context, i) {
                  return buildCard(exercicios[i]);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

buildCard(Exercicio exercicio) {
  return Container(
    padding: EdgeInsets.all(16),
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Color(0xFF031633),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercicio.muscle,
          style: TextStyle(color: Colors.white),
        ),

        Text(
          exercicio.name,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          exercicio.equipment,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          exercicio.instructions,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}

buildAppbar() {
  return AppBar(
    backgroundColor: Color(0xFF031633),
    toolbarHeight: 80,
    centerTitle: true,
    leading: Icon(Icons.arrow_back_ios, color: Colors.white),
    title: Text(
      'EXÉRCICIOS',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    actions: [
      Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              )),
        ],
      ),
    ],
  );
}
