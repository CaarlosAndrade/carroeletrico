import 'package:carroeletrico/components/alteracao_carro_page.dart';
import 'package:carroeletrico/components/cadastro_carro_page.dart';
import 'package:carroeletrico/components/detalhe_carro_page.dart';
import 'package:carroeletrico/components/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carro Elétrico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/carro-detalhe': (context) => const DetalheCarroPage(),
        '/carro-alteracao': (context) => AlteracaoCarroPage()
      },
      initialRoute: '/',
    );
  }
}
