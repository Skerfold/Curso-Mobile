import 'package:flutter/material.dart';
import '../controllers/manutencao_controller.dart';
import '../models/manutencao_model.dart';

class AddManutencaoScreen extends StatefulWidget {
  final int veiculoId;

  const AddManutencaoScreen({super.key, required this.veiculoId});

  @override
  _AddManutencaoScreenState createState() => _AddManutencaoScreenState();
}

class _AddManutencaoScreenState extends State<AddManutencaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final ManutencoesController _controller = ManutencoesController();
  final TextEditingController _tipoServicoController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();
  final TextEditingController _custoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _saveManutencao() async {
    if (_formKey.currentState!.validate()) {
      final manutencao = Manutencao(
        veiculoId: widget.veiculoId,
        tipoServico: _tipoServicoController.text,
        data: DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        ).toIso8601String(),
        quilometragem: int.tryParse(_kmController.text) ?? 0,
        custo: double.tryParse(_custoController.text) ?? 0.0,
        descricao: _descricaoController.text,
      );

      try {
        await _controller.addManutencao(manutencao);
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar manutenção: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _tipoServicoController.dispose();
    _kmController.dispose();
    _custoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Manutenção')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tipoServicoController,
                decoration: InputDecoration(labelText: 'Tipo de Serviço'),
                validator: (value) => value!.isEmpty ? 'Informe o tipo de serviço' : null,
              ),
              TextFormField(
                controller: _kmController,
                decoration: InputDecoration(labelText: 'Quilometragem'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe a quilometragem';
                  if (int.tryParse(value) == null) return 'Quilometragem inválida';
                  return null;
                },
              ),
              TextFormField(
                controller: _custoController,
                decoration: InputDecoration(labelText: 'Custo'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Informe o custo';
                  if (double.tryParse(value) == null) return 'Custo inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição/Observações'),
                maxLines: 2,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Data: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Selecionar Data'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('Hora: ${_selectedTime.format(context)}'),
                  ),
                  TextButton(
                    onPressed: () => _selectTime(context),
                    child: Text('Selecionar Hora'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveManutencao,
                child: Text('Salvar Manutenção'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}