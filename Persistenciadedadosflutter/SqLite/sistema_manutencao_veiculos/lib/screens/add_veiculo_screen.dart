import 'package:flutter/material.dart';
import '../controllers/veiculos_controller.dart';
import '../models/veiculo_model.dart';

class AddVeiculoScreen extends StatefulWidget {
  const AddVeiculoScreen({super.key});

  @override
  _AddVeiculoScreenState createState() => _AddVeiculoScreenState();
}

class _AddVeiculoScreenState extends State<AddVeiculoScreen> {
  final _formKey = GlobalKey<FormState>();
  final VeiculosController _controller = VeiculosController();

  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();

  Future<void> _salvarVeiculo() async {
    if (_formKey.currentState!.validate()) {
      final veiculo = Veiculo(
        marca: _marcaController.text,
        modelo: _modeloController.text,
        ano: int.parse(_anoController.text),
        placa: _placaController.text,
        quilometragemInicial: double.parse(_kmController.text),
      );

      try {
        await _controller.addVeiculo(veiculo);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar veículo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Veículo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _marcaController,
                decoration: InputDecoration(labelText: 'Marca'),
                validator: (value) => value!.isEmpty ? 'Informe a marca' : null,
              ),
              TextFormField(
                controller: _modeloController,
                decoration: InputDecoration(labelText: 'Modelo'),
                validator: (value) => value!.isEmpty ? 'Informe o modelo' : null,
              ),
              TextFormField(
                controller: _anoController,
                decoration: InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o ano';
                  if (int.tryParse(value) == null) return 'Ano inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _placaController,
                decoration: InputDecoration(labelText: 'Placa'),
                validator: (value) => value!.isEmpty ? 'Informe a placa' : null,
              ),
              TextFormField(
                controller: _kmController,
                decoration: InputDecoration(labelText: 'Quilometragem Inicial'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe a quilometragem';
                  if (double.tryParse(value) == null) return 'Quilometragem inválida';
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _salvarVeiculo,
                child: Text('Salvar Veículo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _anoController.dispose();
    _placaController.dispose();
    _kmController.dispose();
    super.dispose();
  }
}