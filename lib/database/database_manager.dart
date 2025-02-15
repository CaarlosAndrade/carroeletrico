import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'carro.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(_carros);
  }

  String get _carros => '''
    CREATE TABLE IF NOT EXISTS carros (
      chassi INTEGER PRIMARY KEY,
      porcentagemCarga INTEGER,
      quilometragem INTEGER,
      controleStatus INTEGER, 
      controleTrava INTEGER,
      apelido TEXT
    );
  ''';
}
