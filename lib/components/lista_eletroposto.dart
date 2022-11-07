import 'package:carroeletrico/api/eletroposto_api.dart';
import 'package:carroeletrico/components/mapa_eletroposto.dart';
import 'package:carroeletrico/model/eletropost_model.dart';
import 'package:flutter/material.dart';

class ListaEletropostoPage extends StatefulWidget {
  @override
  State<ListaEletropostoPage> createState() => _ListaEletropostoPageState();
}

class _ListaEletropostoPageState extends State<ListaEletropostoPage> {
  final api = EletropostoApi();
  late Future<List<Eletroposto>> _futureEletroposto;

  @override
  void initState() {
    _futureEletroposto = api.getListEletroposto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Eletropostos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded(
            child: FutureBuilder<List<Eletroposto>>(
          future: _futureEletroposto,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              var eletropostos = snapshot.data ?? [];
              return ListView.builder(
                itemCount: eletropostos.length,
                itemBuilder: ((context, index) {
                  var eletroposto = eletropostos[index];
                  return Card(
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MapaEletroposto(eletroposto: eletroposto)),
                        )
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 15),
                          textStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      child: ListTile(
                        title: Text(eletroposto.nome),
                        subtitle: Text("Clique para visualizar no mapa"),
                        trailing: Icon(Icons.ev_station_sharp),
                      ),
                    ),
                  );
                }),
              );
            }
          },
        )),
      ),
    );
  }
}
