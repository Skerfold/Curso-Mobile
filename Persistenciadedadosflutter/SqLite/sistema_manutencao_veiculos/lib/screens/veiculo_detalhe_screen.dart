import 'package:flutter/material.dart';
import '../controllers/manutencao_controller.dart';
import '../controllers/veiculos_controller.dart';
import '../models/manutencao_model.dart';
import '../models/veiculo_model.dart';
import 'add_manutencao_screen.dart';

class VeiculoDetalheScreen extends StatefulWidget {
  final int veiculoId;

  const VeiculoDetalheScreen({super.key, required this.veiculoId});

  @override
  _VeiculoDetalheScreenState createState() => _VeiculoDetalheScreenState();
}

class _VeiculoDetalheScreenState extends State<VeiculoDetalheScreen> {
  late Future<Veiculo?> _veiculoFuture;
  late Future<List<Manutencao>> _manutencoesFuture;
  final VeiculosController _veiculosController = VeiculosController();
  final ManutencoesController _manutencoesController = ManutencoesController();

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  void _carregarDados() {
    setState(() {
      _veiculoFuture = _veiculosController.findVeiculoById(widget.veiculoId);
      _manutencoesFuture = _manutencoesController.fetchManutencoesPorVeiculo(widget.veiculoId);
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Detalhes do Veículo')),
    body: FutureBuilder<Veiculo?>(
      future: _veiculoFuture,
      builder: (context, veiculoSnapshot) {
        if (veiculoSnapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (!veiculoSnapshot.hasData) {
          return Center(child: Text('Veículo não encontrado'));
        }

        final veiculo = veiculoSnapshot.data!;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // INFORMAÇÕES DO VEÍCULO
            Card(
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Marca: ${veiculo.marca}', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Modelo: ${veiculo.modelo}'),
                    Text('Ano: ${veiculo.ano}'),
                    Text('Placa: ${veiculo.placa}'),
                    Text('Quilometragem Inicial: ${veiculo.quilometragemInicial} km'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Manutencao>>(
                future: _manutencoesFuture,
                builder: (context, manutencoesSnapshot) {
                  if (manutencoesSnapshot.connectionState != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  }
                  
                  final manutencoes = manutencoesSnapshot.data ?? [];
                  
                  return ListView.builder(
                    itemCount: manutencoes.length,
                    itemBuilder: (context, index) {
                      final manutencao = manutencoes[index];
                      return ListTile(
                        title: Text(manutencao.tipoServico),
                        subtitle: Text('${manutencao.data} - ${manutencao.quilometragem} km'),
                        trailing: Text('R\$${manutencao.custo.toStringAsFixed(2)}'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddManutencaoScreen(veiculoId: widget.veiculoId),
          ),
        );
        _carregarDados();
      },
      child: Icon(Icons.add),
    ),
  );
}
}