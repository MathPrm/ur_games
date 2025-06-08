import 'package:flutter/material.dart';
import 'package:ur_games/auth/auth_service.dart';
import 'package:ur_games/pages/login_page.dart';
import 'package:ur_games/style.dart';
import 'package:ur_games/widget/password_input.dart';
import 'package:ur_games/widget/primary_button.dart';
import 'package:ur_games/widget/text_input.dart';

class RegisterPage extends  StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Get auth service
  final authService = AuthService();

  // Text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmedPasswordController = TextEditingController();

  // Sign up button pressed
  void signup() async {
    // Prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmedPasswordController.text;

    // check if passwords match
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Les mots de passe ne sont pas identiques!")));
      return;
    }

    // attempt sign up
    try {
      await authService.signUpWithEmailPassword(email, password);

      // pop this register page
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: formContainer(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
              TextInput(controller: _emailController, label: "Email"),
              const SizedBox(height: 10),
              PassInput(controller: _passwordController, label: "Mot de passe"),
              const SizedBox(height: 10),
              PassInput(controller: _confirmedPasswordController, label: "confirmez le mot de passe"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
                children: [
                  PrimaryButton(text: "S'Inscire", function: () async {signup();}),
                  // Redirect to sign up page if user doesn't have an account
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LoginPage(),)),
                child: Center(child: Text("Déjà inscrit? Cliquez sur ce lien pour vous connecter")),
              )
            ],
          ),
        ),
      ),
    );
  }
}