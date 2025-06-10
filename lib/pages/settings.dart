import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFF0F1320), // Couleur de fond spécifique
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Paramètre',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png'), // Remplace par ton asset
                  ),
                ],
              ),
            ),
            // Ajoute ici le reste du contenu de ta page
          ],
        ),
      ),
    );
  }
}