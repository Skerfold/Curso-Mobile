import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_firebase/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); //garantir a inicialização dos bindings
  // inicializa o firebase ao mesmo tempo que o app 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(
    title: "Lista de Tarefas",
    home: AutenticacaoView(),
  ));
}