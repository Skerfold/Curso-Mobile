// Exemplo de Convert Json

import 'dart:convert'; //biblioteca para funcionamento do Json

void main() {
  // Texto em formato JSON
  String dbJson = '''{
            "id":1,
            "nome": "João",
            "login": "joao_user",
            "ativo": true,
            "senha": 1234
                }''';

  // Convertendo texto JSON -> Map Dart
  Map<String, dynamic> usuario = json.decode(dbJson);

  print(usuario["login"]); //joao_user

  //mudar a senha do usuario p/ 1111

  usuario["senha"] = 1111;

  // fazer o encode -> Map Dart -> Texto JSON

  dbJson = json.encode(usuario);

  // printar o json

  print(dbJson);
}
