import 'package:flutter/material.dart';
import '../widget/header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        child: Header(namePage:"PROFIL"),
      )
    );
  }
}