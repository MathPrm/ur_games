import 'package:flutter/material.dart';
import 'package:ur_games/auth/auth_service.dart';
import 'package:ur_games/style.dart';
import 'package:ur_games/widget/primary_button.dart';
import 'package:ur_games/widget/text_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Get auth service
  final authService = AuthService();

  // Text controllers
  final _emailcontroller = TextEditingController();
  final _passwordController = TextEditingController();

  // Login button pressed
  void login() async {
    // Prepare data
    final email = _emailcontroller.text;
    final password = _passwordController.text;

    // Attempt login
    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  // BUILD UI
 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: formContainer(
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            TextInput(controller: _emailcontroller, label: "Email"),
            const SizedBox(height: 10),
            TextInput(controller: _passwordController, label: "Mot de passe"),
            const SizedBox(height: 20),
             Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
              children: [
                PrimaryButton(text: "Se Connecter", function: () async {login();}),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
}



