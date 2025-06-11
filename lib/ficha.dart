import 'package:flutter/material.dart';

class Ficha extends StatefulWidget {
  const Ficha({super.key});

  @override
  State<Ficha> createState() => _FichaState();
}

class _FichaState extends State<Ficha> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF49d3ee),
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios),
          actions: [
            Icon(Icons.comment_bank_outlined),
          ],
          title: Text(
            "Ficha",
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF49d3ee),
          toolbarHeight: 100,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(""),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 14),
              padding: EdgeInsets.all(24),
              color: Color(0xFF0097b2),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(25)),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("DADOS DA FICHA AVALIATIVA:")),
                    Padding(padding: EdgeInsets.all(15)),
                    Table(
                      border: TableBorder.all(),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(
                          children: <Widget>[
                            Container(
                                height: 32, child: Text("xxnkcdskakdhashkd")),
                            Container(
                                height: 32, child: Text("xxnkcdskakdhashkd")),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Container(
                                height: 32, child: Text("xxnkcdskakdhashkd")),
                            Container(
                                height: 32, child: Text("xxnkcdskakdhashkd")),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Container(
                                height: 32, child: Text("xxnkcdskakdhashkd")),
                            Container(
                                height: 32, child: Text("xxnkcdskakdhashkd")),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        height: 90,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Color(0xFF0097b2),
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: Text(
                          "Nível de jogabilidade do pulmão: ",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 300,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFF123870), // background color
                            foregroundColor: Colors.white, // text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: Text('Voltar'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xFF123870), // background color
                            foregroundColor: Colors.white, // text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {},
                          child: Text('Próximo'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
