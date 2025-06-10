import 'package:flutter/material.dart';
import 'package:ur_games/auth/auth_service.dart';
import 'package:ur_games/pages/register_page.dart';
import 'package:ur_games/style.dart';
import 'package:ur_games/widget/password_input.dart';
import 'package:ur_games/widget/primary_button.dart';
import 'package:ur_games/widget/text_input.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
    // BUILD UI
  final authService = AuthService();

  // Text controllers
  final _emailcontroller = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: formContainer(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
              TextInput(controller: _usernameController, label: "Nom d'utilisateur"),
              const SizedBox(height: 10),
              TextInput(controller: _emailcontroller, label: "Email"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                children: [
                  PrimaryButton(text: "Se Connecter", function: () async {}),
                  // Redirect to sign up page if user doesn't have an account
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}