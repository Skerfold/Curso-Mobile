import '../database/db_helper.dart';
import '../models/manutencao_model.dart';

class ManutencoesController {
  final GarageDBHelper _dbHelper = GarageDBHelper();

  Future<int> addManutencao(Manutencao manutencao) async {
    return await _dbHelper.insertManutencao(manutencao);
  }

  Future<List<Manutencao>> fetchManutencoesPorVeiculo(int veiculoId) async {
    return await _dbHelper.getManutencoesPorVeiculo(veiculoId);
  }

  Future<int> deleteManutencao(int id) async {
    return await _dbHelper.deleteManutencao(id);
  }
}