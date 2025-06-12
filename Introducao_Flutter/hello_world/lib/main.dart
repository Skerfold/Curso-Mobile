import 'package:flutter/material.dart';

void main() {   //a programação
  runApp(const MainApp());
}

class MainApp extends StatelessWidget { // pagina de construção 
  const MainApp({super.key}); //modelo de página

  @override
  Widget build(BuildContext context) { 
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}





























