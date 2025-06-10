import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ur_games/auth/auth_gate.dart';
import 'package:ur_games/secret/env.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: URL,
    anonKey: ANNON_KEY,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF2A354C), // Couleur de fond en hexadécimal
      ),
      home: AuthGate(),
    );
  }
}
