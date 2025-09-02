import 'package:flutter/material.dart';
import 'package:inspiravida/pages/cardapio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedIndex = 0;

  var pages = [
    Cardapio(),
    Cardapio(),
    Cardapio(),
    Cardapio()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[selectedIndex],
        appBar: buildAppBar(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          backgroundColor: Color(0xFF0A1931),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontSize: 10),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configuração'),
            BottomNavigationBarItem(icon: Icon(Icons.table_chart), label: 'Ficha'),
            BottomNavigationBarItem(icon: Icon(Icons.on_device_training), label: 'Exercício')
          ],
        ),
      ),
    );
  }

  buildAppBar(){
    return AppBar(
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.menu))
      ],
      leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
    );
  }
}
