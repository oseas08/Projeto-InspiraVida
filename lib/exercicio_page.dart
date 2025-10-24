import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspiravida/api/exercicio_api.dart';
import 'package:inspiravida/exercicio.dart';


class ExercicioPage extends StatefulWidget {
  const ExercicioPage({super.key});


  @override
  State<ExercicioPage> createState() => _ExercicioPageState();
}


class _ExercicioPageState extends State<ExercicioPage> {
  late Future<List<Exercicio>> futureExercicios;
  late Future<List<Exercicio>> futureExerciciosFake;


  @override
  void initState() {
    super.initState();
    futureExercicios = ExercicioApi().findExercicios();
    futureExerciciosFake = ExercicioApi().findExerciciosFake();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppbar(),
        body: FutureBuilder(
          future: futureExercicios,
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
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.grey.shade500,
          ),
        child:
        Text(
          exercicio.name,
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20),
        ),
        ),
        Text(
          exercicio.muscle,
          style: TextStyle(color: Colors.black),
        ),
        Text(
          exercicio.equipment,
          style: TextStyle(color: Colors.black),
        ),
        Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 3),
              ),
            ],
          ),
  child:
  Text(
          exercicio.instructions,
          style: TextStyle(color: Colors.black),
        ),
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
