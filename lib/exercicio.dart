import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class exercicio extends StatefulWidget {
  const exercicio({super.key});

  @override
  State<exercicio> createState() => _exercicioState();
}

class _exercicioState extends State<exercicio> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppbar(),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  margin: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xFF031633),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('data do aniversário da Arielly está chegando',
                      style: TextStyle(color: Colors.white),)
                    ],
                      ),
      ),
                  ],
        ),
            ]
        ),
        ),
      );
  }
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
                onPressed: () {}, icon: Icon(Icons.menu,
            color: Colors.white,)),
          ],
      ),
      ],
    );
}
