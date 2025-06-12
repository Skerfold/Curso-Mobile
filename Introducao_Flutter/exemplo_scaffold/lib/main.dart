// VOID MAIN
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //estudo do scaffold
      home: Scaffold(
        //barra de navegação superior
        appBar: AppBar(
          title: Text("exemplo AppBar"),
          backgroundColor: Colors.blue,
        ),
        //corpo do app
          body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                  Stack(
                    alignment: Alignment.center,
                    children:[
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.red
                        
                      ),
                      Icon(Icons.person)
                    ],
                  ),
                  Text("Coluna 2"),
                  Text("Coluna 3")],
                  ),
                  Text("Linha 2"),
                  Text("Libha 3"),
              ],
                    ),
          ) ,
        //barra lateral (menu hamburger)
        drawer: Drawer(
          child: ListView(
            children: [Text("inicio"), Text("conteudo"), Text("contato")],
          ),
        ),
        //barra de navegação inferior
       
       
        //botão flutuante
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Botão Clicado");
          },
          child: Icon(Icons.add),  
        ),
      ),
    );
  }
}