import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatefulWidget {
  const RegistroView({super.key});

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confirmarSenhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;
  bool _senhaOculta = true;
  bool _confirmarSenhaOculta = true;

  // Método de registro
  void _registrar() async {
    if (_senhaField.text != _confirmarSenhaField.text) return;
    try {
      await _authController.createUserWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao registrar: $e")),
      );
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registro")),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailField,
                  decoration: InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  key: Key('registro_password_field'),
                  controller: _senhaField,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _senhaOculta = !_senhaOculta;
                        });
                      },
                      icon: Icon(
                        _senhaOculta ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _senhaOculta,
                ),
                TextField(
                  key: Key('registro_confirm_password_field'),
                  controller: _confirmarSenhaField,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _confirmarSenhaOculta = !_confirmarSenhaOculta;
                        });
                      },
                      icon: Icon(
                        _confirmarSenhaOculta ? Icons.visibility_off : Icons.visibility,
                      ),
                      
                    ),
                  ),
                  obscureText: _confirmarSenhaOculta,
                ),

                SizedBox(height: 20),
                ElevatedButton(onPressed: _registrar, child: Text("Registrar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}