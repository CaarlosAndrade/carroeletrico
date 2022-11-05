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
        title: const Text("Lista Eletroposto"),
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
                  return ListTile(
                    title: Text(eletroposto.nome),
                    trailing: ElevatedButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapaEletroposto()),
                        )
                      },
                      child: Text("Abrir Mapa"),
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
