import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Imagem de perfil, nome e localização
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/img/image.png"), 
              ),
              SizedBox(height: 10),
              Text(
                "Lucas",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Brasil",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 20),

              // Lista de itens com ícones e textos
              ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text("Pessoal"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.favorite, color: Colors.green),
                title: Text("Mwa"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.payment, color: Colors.green),
                title: Text("Pagamento"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.shop, color: Colors.green),
                title: Text("Recomendados"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Sair"),
                onTap: () {},
              ),
            ],
          ),
        ),

        // BottomNavigationBar com ícones de redes sociais
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
