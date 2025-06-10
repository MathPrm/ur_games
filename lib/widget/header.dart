import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String namePage;
  const Header({
    super.key,
    required this.namePage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F1320), // Couleur de fond spécifique
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      height: 60, // Hauteur fixe pour le header
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              namePage,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: CircleAvatar(
              backgroundImage: const AssetImage('assets/avatar.png'), // Remplace par ton asset
            ),
          ),
        ],
      ),
    );
  }
}