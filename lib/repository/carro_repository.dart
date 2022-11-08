import 'package:carroeletrico/database/database_manager.dart';
import 'package:carroeletrico/model/carro_model.dart';
import 'package:carroeletrico/model/enum/controle_status.dart';
import 'package:carroeletrico/model/enum/controle_trava.dart';

class CarroRepository {
  Future<void> cadastrarCarro(Carro carro) async {
    final db = await DatabaseManager().getDatabase();

    db.insert("carros", {
      "apelido": carro.apelido,
      "chassi": carro.chassi,
      "controleStatus": carro.controleStatus.index,
      "controleTrava": carro.controleTrava.index,
      "quilometragem": carro.quilometragem,
      "porcentagemCarga": carro.porcentagemCarga,
    });
  }

  Future<List<Carro>> listarCarro() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT chassi, porcentagemCarga, quilometragem, controleStatus, controleTrava, apelido
          FROM carros
          ''');
    return rows
        .map(
          (row) => Carro(
              chassi: row['chassi'],
              porcentagemCarga: row['porcentagemCarga'],
              quilometragem: row['quilometragem'],
              controleStatus: ControleStatus.values[row['controleStatus']],
              controleTrava: ControleTrava.values[row['controleTrava']],
              apelido: row['apelido']),
        )
        .toList();
  }

  Future<void> deletarCarro(int chassi) async {
    final db = await DatabaseManager().getDatabase();

    await db.delete('carros', where: 'chassi = ?', whereArgs: [chassi]);
  }

  Future<int> atualizarCarro(Carro carro) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        "carros",
        {
          "apelido": carro.apelido,
          "controleStatus": carro.controleStatus.index,
          "controleTrava": carro.controleTrava.index,
          "quilometragem": carro.quilometragem,
        },
        where: 'chassi = ?',
        whereArgs: [carro.chassi]);
  }
}
