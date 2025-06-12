// classe TelaConfirmcao

import 'package:flutter/material.dart';

class TelaConfirmacaoView extends StatelessWidget {
  const TelaConfirmacaoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Corfimação de Cadastro")),
      body: Center(
        child: Column(
          children: [
            Text("Cadastro Realizado com Sucesso"),
            SizedBox(height: 20),
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              icon: Icon(Icons.home, size: 50, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
