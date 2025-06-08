import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ur_games/auth/auth_gate.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://qcujpgrywgkvjxxsrkjc.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFjdWpwZ3J5d2drdmp4eHNya2pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkzMDQ4MzgsImV4cCI6MjA2NDg4MDgzOH0.apRIfZat4n7ZtNVKjEGWs4t6Y9ALdSHHmpmRQrYoCkc",
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF2A354C), // Couleur de fond en hexadécimal
      ),
      home: AuthGate(),
    );
  }
}
