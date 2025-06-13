import 'package:flutter/material.dart';
import 'add_veiculo_screen.dart';
import 'veiculo_detalhe_screen.dart';
import '../controllers/veiculos_controller.dart';
import '../models/veiculo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VeiculosController _controller = VeiculosController();
  late Future<List<Veiculo>> _veiculosFuture;

  @override
  void initState() {
    super.initState();
    _carregarVeiculos();
  }

  void _carregarVeiculos() {
    setState(() {
      _veiculosFuture = _controller.fetchVeiculos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Veículos')),
      body: FutureBuilder<List<Veiculo>>(
        future: _veiculosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum veículo cadastrado'));
          }
          
          final veiculos = snapshot.data!;
          
          return ListView.builder(
            itemCount: veiculos.length,
            itemBuilder: (context, index) {
              final veiculo = veiculos[index];
              return ListTile(
                title: Text('${veiculo.marca} ${veiculo.modelo}'),
                subtitle: Text('Placa: ${veiculo.placa}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VeiculoDetalheScreen(veiculoId: veiculo.id!),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVeiculoScreen()),
          );
          _carregarVeiculos();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}