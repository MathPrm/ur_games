import 'package:flutter/material.dart';
import '../widget/header.dart';
class AddFriend extends StatelessWidget {
  const AddFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(namePage:"Mon ami"),
            // Ajoute ici le reste du contenu de ta page
          ],
        ),
      ),
    );
  }
}
