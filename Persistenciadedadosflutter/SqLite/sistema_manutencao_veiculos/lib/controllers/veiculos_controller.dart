import '../database/db_helper.dart';
import '../models/veiculo_model.dart';

class VeiculosController {
  final GarageDBHelper _dbHelper = GarageDBHelper();

  Future<int> addVeiculo(Veiculo veiculo) async {
    return await _dbHelper.insertVeiculo(veiculo);
  }

  Future<List<Veiculo>> fetchVeiculos() async {
    return await _dbHelper.getVeiculos();
  }

  Future<Veiculo?> findVeiculoById(int id) async {
    return await _dbHelper.getVeiculoById(id);
  }

  Future<int> deleteVeiculo(int id) async {
    return await _dbHelper.deleteVeiculo(id);
  }
}