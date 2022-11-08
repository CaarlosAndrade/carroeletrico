import 'dart:async';

import 'package:carroeletrico/components/alteracao_carro_page.dart';
import 'package:carroeletrico/components/cadastro_carro_page.dart';
import 'package:carroeletrico/model/carro_model.dart';
import 'package:carroeletrico/model/enum/controle_status.dart';
import 'package:carroeletrico/repository/carro_repository.dart';
import 'package:flutter/material.dart';

class ListaCarroPage extends StatefulWidget {
  const ListaCarroPage({Key? key}) : super(key: key);

  @override
  State<ListaCarroPage> createState() => _ListaCarroPage();
}

class _ListaCarroPage extends State<ListaCarroPage> {
  final _carroRepository = CarroRepository();
  late Future<List<Carro>> _carros;

  @override
  void initState() {
    carregarCarros();
    super.initState();
  }

  void carregarCarros() {
    _carros = _carroRepository.listarCarro();
  }

  onGoBack(dynamic value) {
    carregarCarros();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Carros Cadastrados'),
            automaticallyImplyLeading: false),
        body: FutureBuilder<List<Carro>>(
          future: _carros,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final carros = snapshot.data ?? [];
              return ListView.separated(
                itemCount: carros.length,
                itemBuilder: (context, index) {
                  final carro = carros[index];

                  final controleStatus =
                      carro.controleStatus == ControleStatus.Ligado
                          ? 'Ligado'
                          : 'Desligado';

                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.delete_forever),
                    ),
                    secondaryBackground: Container(
                      color: Colors.blue,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.edit),
                    ),
                    key: ValueKey<Carro>(carro),
                    child: ListTile(
                      title: Text(carro.apelido),
                      subtitle:
                          Text('Chave Eletrônica Virtual: $controleStatus'),
                      onTap: (() => Navigator.pushNamed(
                          context, '/carro-detalhe',
                          arguments: carro)),
                    ),
                    onDismissed: (DismissDirection direction) async {
                      if (direction == DismissDirection.endToStart) {
                        await _carroRepository.deletarCarro(carro.chassi!);
                        setState(() {
                          carros.removeAt(index);
                        });
                      } else {
                        //
                        Route route = MaterialPageRoute(
                            builder: (context) => AlteracaoCarroPage(
                                  carroParaEdicao: carro,
                                ));
                        Navigator.push(context, route).then(onGoBack);
                      }
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            }
            return Container();
          },
        ));
  }
}
