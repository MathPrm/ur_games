/*

AUTH GATE - This file continuously listen for auth state changes.

-----------------------------------------------------

unauthenticated -> returns to login page
authenticated -> returns Profile Page

*/

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ur_games/pages/edit_profile_page.dart';
import 'package:ur_games/pages/login_page.dart';
import 'package:ur_games/pages/profile_page.dart';
import '../content.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Listen to auth state changes
      stream: Supabase.instance.client.auth.onAuthStateChange,

      // Build appropriate page based on auth state
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Check if there is a valid session currently
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          // return EditProfilePage();
          return const Content();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}