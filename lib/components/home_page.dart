import 'package:carroeletrico/components/cadastro_carro_page.dart';
import 'package:carroeletrico/components/lista_carro_page.dart';
import 'package:carroeletrico/components/lista_eletroposto.dart';
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
          ListaCarroPage(),
          ListaEletropostoPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Empresa'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline), label: 'Cadastro'),
          BottomNavigationBarItem(
              icon: Icon(Icons.electric_car_outlined), label: 'Garagem'),
          BottomNavigationBarItem(
              icon: Icon(Icons.electric_bolt_sharp), label: 'Eletropostos'),
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
