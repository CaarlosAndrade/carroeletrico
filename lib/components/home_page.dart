import 'package:carroeletrico/components/cadastro_carro_page.dart';
import 'package:carroeletrico/components/lista_carro_page.dart';
import 'package:carroeletrico/components/sobre_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: paginaAtual);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: setPaginaAtual,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          SobrePage(),
          CadastroCarroPage(),
          ListaCarroPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'Sobre'),
          BottomNavigationBarItem(
              icon: Icon(Icons.electric_car_outlined), label: 'Cadastro'),
          BottomNavigationBarItem(
              icon: Icon(Icons.electric_car_outlined), label: 'Meus Carros'),
        ],
        onTap: (pagina) {
          controller.animateToPage(
            pagina,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }
}
