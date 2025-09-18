import 'package:flutter/material.dart';
import 'package:formativa_cine_favorite/views/login_view.dart';
import 'package:formativa_cine_favorite/views/registro_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate back to login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
              child: Text('Go to Login Screen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to registration screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistroView()),
                );
              },
              child: Text('Go to Registration Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
