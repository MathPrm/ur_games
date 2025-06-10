import 'package:flutter/material.dart';
import 'package:ur_games/auth/auth_service.dart';
import 'package:ur_games/style.dart';
import 'package:ur_games/widget/file_picker_button.dart';
import 'package:ur_games/widget/primary_button.dart';
import 'package:ur_games/widget/text_input.dart';
import 'package:ur_games/services/profile_service.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
    // BUILD UI
  final authService = AuthService();
  final profileService = ProfileService();

  // Text controllers
  final _emailcontroller = TextEditingController();
  final _usernameController = TextEditingController();

  Future<Map<String, dynamic>>? profileFuture;

  @override
  void initState() {
    super.initState();
    profileFuture = profileService.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: formContainer(
          child: FutureBuilder<Map<String, dynamic>>(
            future: profileFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final profile = snapshot.data!;
              
              // Set initial values for controllers
              _usernameController.text = profile['username'] ?? '';
              _emailcontroller.text = profile['email'] ?? '';

              return ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 20),
                  TextInput(controller: _usernameController, label: "Nom d'utilisateur"),
                  const SizedBox(height: 10),
                  TextInput(controller: _emailcontroller, label: "Email"),
                  const SizedBox(height: 20),
                  Center(
                    child: FilePickerButton(icon: Icons.add),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                        icon: Icons.save,
                        text: "Enregistrer",
                        function: () async {
                          await profileService.updateProfile(
                            username: _usernameController.text,
                            email: _emailcontroller.text,
                          );
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profile updated successfully')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}