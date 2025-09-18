import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formativa_cine_favorite/views/registro_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;
  bool _senhaOculta = true;

  // Método
  void _Login() async {
    try {
      // Solicitar a autenticação
      await _authController.signInWithEmailAndPassword(
        email: _emailField.text.trim(),
        password: _senhaField.text,
      );
      // Não precisa de navigator, pois usaremos o StreamBuilder
      // Faz o direcionamento automático para a tela inicial
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao fazer login! $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailField,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              key: Key('login_password_field'),
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
            SizedBox(height: 20),
            ElevatedButton(onPressed: _Login, child: Text("Login")),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegistroView()),
              ),
              child: Text("Não tem uma conta? Registre-se agora!"),
            ),
          ],
        ),
      ),
    );
  }
}
