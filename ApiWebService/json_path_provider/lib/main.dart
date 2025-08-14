import 'dart:convert';
import 'dart:io'; // biblioteca nativa do dart para manipulação de arquivos

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() =>
    runApp(MaterialApp(home: ProdutoPage(), debugShowCheckedModeBanner: false));

class ProdutoPage extends StatefulWidget {
  // construtor => super.key
  const ProdutoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProdutoPageState();
  }
}

//classe que vai construir a tela para as mudanças
class _ProdutoPageState extends State<ProdutoPage> {
  //atributos
  List<Map<String, dynamic>> produtos = [];
  final TextEditingController _nomeProdutoController = TextEditingController();
  final TextEditingController _valorProdutoController = TextEditingController();

  // métodos
  // métodos para carregar informações antes de construir a página
  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  // método para retornar o arquivo interno do meu dispositivo
  Future<File> _getFile() async {
    //busca a pasta de documentos do dispositivo
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/produtos.json");
  }

  // busco as informações a salvo na lista
  void _carregarProdutos() async {
    // tratamento de erros
    try {
      final file = await _getFile();
      // ler o arquivo como String => armazeno dentro da variável conteudo
      String conteudo = await file.readAsString();
      // decodificar o texto/json para Dart
      List<dynamic> dados = json.decode(conteudo);
      setState(() {
        produtos = dados.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      setState(() {
        produtos = [];
      });
      print(e);
    }
  }

  // salvar os produtos da lista para o Json
  void _salvarProdutos() async {
    try {
      final file = await _getFile();
      String jsonProdutos = json.encode(produtos);
      await file.writeAsString(jsonProdutos);
    } catch (e) {
      print(e);
    }
  }

  // Método para adicionar produto na lista de produtos
  void _adicionarProduto(BuildContext context) {
    String nome = _nomeProdutoController.text.trim();
    String valorStr = _valorProdutoController.text.trim();
    if (nome.isEmpty || valorStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Preencha o nome e o valor do produto!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    double? valor = double.tryParse(valorStr);
    if (valor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Valor inválido!"), backgroundColor: Colors.red),
      );
      return;
    }
    final produto = {"nome": nome, "valor": valor};
    setState(() {
      // adiciona o produto dentro do vetor
      produtos.add(produto);
    });
    _salvarProdutos();
    _nomeProdutoController.clear();
    _valorProdutoController.clear();
  }

  // Método para remover produto da lista produtos
  void _removerProduto(int index) {
    setState(() {
      produtos.removeAt(index);
    });
    _salvarProdutos();
  }

  //build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Produtos")),
      body: Builder(
        builder: (context) => Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _nomeProdutoController,
                decoration: InputDecoration(labelText: "Nome do Produto"),
              ),
              TextField(
                controller: _valorProdutoController,
                decoration: InputDecoration(labelText: "Valor (ex: 15.55)"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _adicionarProduto(context), // Passe o contexto
                child: Text("Adicionar Produto"),
              ),
              Divider(),
              Expanded(
                child: produtos.isEmpty
                    ? Center(child: Text("Nenhum produto adicionado."))
                    : ListView.builder(
                        itemCount: produtos.length,
                        itemBuilder: (context, index) {
                          final produto = produtos[index];
                          return ListTile(
                            title: Text(produto["nome"]),
                            subtitle: Text("R\$ ${produto["valor"]}"),
                            trailing: IconButton(
                              onPressed: () => _removerProduto(index),
                              icon: Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
