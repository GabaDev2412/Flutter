import 'package:app_cripto/pages/favoritas_page.dart';
import 'package:app_cripto/pages/moedas_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController page;

  @override
  void initState() {
    super.initState();
    page = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: page,
        onPageChanged: setPaginaAtual,
        children: [
          const MoedasPage(),
          FavoritasPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritas'),
        ],
        onTap: (pagina) {
          page.animateToPage(pagina,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
