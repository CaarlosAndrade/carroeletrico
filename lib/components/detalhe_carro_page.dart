import 'package:carroeletrico/model/carro_model.dart';
import 'package:carroeletrico/model/enum/controle_status.dart';
import 'package:carroeletrico/model/enum/controle_trava.dart';
import 'package:flutter/material.dart';

class DetalheCarroPage extends StatelessWidget {
  const DetalheCarroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carro = ModalRoute.of(context)!.settings.arguments as Carro;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.greenAccent, title: Text(carro.apelido)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Chave Eletrônica Virtual'),
              subtitle: Text(carro.controleStatus == ControleStatus.Desligado
                  ? 'Carro Desligado'
                  : 'Carro Ligado'),
            ),
            ListTile(
              title: const Text('Controle de Travas'),
              subtitle: Text(carro.controleTrava == ControleTrava.Travado
                  ? 'Travado'
                  : 'Destravado'),
            ),
            ListTile(
                title: const Text('Quilometragem Percorrida'),
                subtitle: Text("${carro.quilometragem} km")),
            ListTile(
              title: const Text('Porcentagem de Carga'),
              subtitle: Text("${carro.porcentagemCarga}%"),
            ),
            ListTile(
              title: const Text('N° do Chassi'),
              subtitle: Text(carro.chassi.toString()),
            )
          ],
        ),
      ),
    );
  }
}
