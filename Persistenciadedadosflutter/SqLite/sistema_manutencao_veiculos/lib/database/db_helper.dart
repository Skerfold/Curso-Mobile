import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/veiculo_model.dart';
import '../models/manutencao_model.dart';

class GarageDBHelper {
  static final GarageDBHelper _instance = GarageDBHelper._internal();
  factory GarageDBHelper() => _instance;
  GarageDBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'garage.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE veiculos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            marca TEXT NOT NULL,
            modelo TEXT NOT NULL,
            ano INTEGER NOT NULL,
            placa TEXT NOT NULL,
            quilometragemInicial REAL NOT NULL
          )
        ''');
        await db.execute('''
  CREATE TABLE manutencoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    veiculoId INTEGER NOT NULL,
    tipoServico TEXT NOT NULL,
    data TEXT NOT NULL,
    quilometragem INTEGER NOT NULL,
    custo REAL NOT NULL,
    descricao TEXT NOT NULL,
    FOREIGN KEY (veiculoId) REFERENCES veiculos(id) ON DELETE CASCADE
  )
''');
      },
    );
  }

  // Métodos para Veiculo (já existentes)
  Future<int> insertVeiculo(Veiculo veiculo) async {
    final db = await database;
    return await db.insert(
      'veiculos',
      veiculo.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Veiculo>> getVeiculos() async {
    final db = await database;
    final maps = await db.query('veiculos');
    return maps.map((map) => Veiculo.fromMap(map)).toList();
  }

  Future<Veiculo?> getVeiculoById(int id) async {
    final db = await database;
    final maps = await db.query('veiculos', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Veiculo.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteVeiculo(int id) async {
    final db = await database;
    return await db.delete('veiculos', where: 'id = ?', whereArgs: [id]);
  }

  // Métodos para Manutencao
  Future<int> insertManutencao(Manutencao manutencao) async {
    final db = await database;
    return await db.insert(
      'manutencoes',
      manutencao.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Manutencao>> getManutencoesPorVeiculo(int veiculoId) async {
    final db = await database;
    final maps = await db.query(
      'manutencoes',
      where: 'veiculoId = ?',
      whereArgs: [veiculoId],
      orderBy: 'data DESC',
    );
    return maps.map((map) => Manutencao.fromMap(map)).toList();
  }

  Future<int> deleteManutencao(int id) async {
    final db = await database;
    return await db.delete('manutencoes', where: 'id = ?', whereArgs: [id]);
  }
}