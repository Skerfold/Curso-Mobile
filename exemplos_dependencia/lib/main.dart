import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){ //método principal para rodar a aplicação
  runApp (MyApp()); // ocnstrutor da classe  principal 
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
//classe principal
@override
Widget build(BuildContext context){
  return MaterialApp(
    home: Scaffold (
      appBar: AppBar(
        title: Text("Exemplo App Dependência"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Fluttertoast.showToast(
              msg: "Olá, Mundo!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER);
          },
          child: Text("Clique Aqui!")),
      ),
      ), 
    );
  }
}
