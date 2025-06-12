import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TelaCadastro(),
  ));
}

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  String nome = "";
  String email = "";
  String senha = "";
  String genero = "";
  String dataNascimento = "";
  double _experiencia = 0;
  bool _aceite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Usuário"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: "Nome",
                validator: (value) =>
                    value!.isEmpty ? "Digite seu Nome" : null,
                onSaved: (value) => nome = value!,
              ),
              SizedBox(height: 10),
              _buildTextField(
                label: "E-mail",
                validator: (value) => value!.contains("@")
                    ? null
                    : "Digite um e-mail válido",
                onSaved: (value) => email = value!,
              ),
              SizedBox(height: 10),
              _buildTextField(
                label: "Senha",
                obscureText: true,
                validator: (value) => value!.length < 6
                    ? "A senha deve ter no mínimo 6 caracteres"
                    : null,
                onSaved: (value) => senha = value!,
              ),
              SizedBox(height: 10),
              Text("Gênero"),
              DropdownButtonFormField(
                items: ["Masculino", "Feminino", "Outro"].map((String genero) {
                  return DropdownMenuItem(
                    value: genero,
                    child: Text(genero),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    genero = value.toString();
                  });
                },
                validator: (value) =>
                    value == null ? "Selecione um gênero" : null,
                value: genero.isEmpty ? null : genero,
              ),
              SizedBox(height: 10),
              _buildTextField(
                label: "Data de Nascimento",
                validator: (value) => value!.isEmpty
                    ? "Digite a data de nascimento"
                    : null,
                onSaved: (value) => dataNascimento = value!,
              ),
              SizedBox(height: 10),
              Text("Experiência (anos):"),
              Slider(
                value: _experiencia,
                min: 0,
                max: 20,
                divisions: 20,
                label: _experiencia.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _experiencia = value;
                  });
                },
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                value: _aceite,
                title: Text("Aceito os termos de uso"),
                onChanged: (value) => setState(() {
                  _aceite = value!;
                }),
              ),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: _enviarFormulario,
                  child: Text("Enviar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
    bool obscureText = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
    );
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (!_aceite) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Você deve aceitar os termos de uso!")),
        );
        return;
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Dados do Formulário"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nome: $nome"),
              Text("Email: $email"),
              Text("Gênero: $genero"),
              Text("Data de Nascimento: $dataNascimento"),
              Text("Experiência: ${_experiencia.round()} anos"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Fechar"),
            ),
          ],
        ),
      );
    }
  }
}