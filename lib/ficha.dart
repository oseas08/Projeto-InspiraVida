
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
          leading: Icon(Icons.arrow_back_ios, color: Colors.black,),
          actions: [
            Icon(Icons.comment_bank_outlined, color: Colors.black,),
          ],
          title: construirTexto(
            texto: "Ficha",
            cor: Colors.black,
            tamanhoFonte: 20.0,
            pesoFonte: FontWeight.bold,
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF49d3ee),
          toolbarHeight: 100,
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
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
                      alignment: Alignment.center,
                      child: construirTexto(
                        texto: "DADOS DA FICHA AVALIATIVA",
                        cor: Colors.black,
                        tamanhoFonte: 16.0,
                        pesoFonte: FontWeight.w600,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(15)),
                    Table(
                      border: TableBorder.all(),
                      defaultVerticalAlignment:
                      TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "Tempo para fumar ao acordar: ",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "...",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "Fuma em locais proibidos: ",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "...",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "Cigarros por dia:",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "...",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),

                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "Fuma doente:",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "...",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),

                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "Idade que começou a fumar:",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "...",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),

                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "Gênero:",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "...",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),

                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "Atividade física:",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "...",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),

                            ),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: "Alimentação:",
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: construirTexto(
                                texto: ("..."),
                                cor: Colors.black,
                                tamanhoFonte: 12.0,
                                pesoFonte: FontWeight.normal,
                              ),

                            ),
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
                        child: construirTexto(
                          texto: "Nível de jogabilidade do pulmão: ",
                          cor: Colors.white,
                          tamanhoFonte: 18.0,
                          pesoFonte: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 130,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Color(0xFF0097b2), // background color
                            foregroundColor: Colors.white, // text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {},
                          child: Text('Voltar'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Color(0xFF0097b2), // background color
                            foregroundColor: Colors.white, // text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            textStyle: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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

  Widget construirTexto({
    required String texto,
    Color? cor,
    double? tamanhoFonte,
    FontWeight? pesoFonte,
  }) {
    return Text(
      texto,
      style: GoogleFonts.inter(
        color: cor ?? Colors.black,
        fontSize: tamanhoFonte ?? 14.0,
        fontWeight: pesoFonte ?? FontWeight.normal,
      ),
      textAlign: TextAlign.center,
    );
  }
}