import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FilePickerButton extends StatelessWidget {
  final IconData icon;

  const FilePickerButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    Future<void> pickImage() async {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );
        
        if (result != null) {
          if (kIsWeb) {
            // Handle web platform
            final bytes = result.files.single.bytes;
            final fileName = result.files.single.name;
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image sélectionnée: $fileName')),
            );
          } else {
            // Handle native platforms
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image sélectionnée: ${result.files.single.name}')),
            );
          }
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Aucun fichier sélectionné')),
          );
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }

    return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF6289FB), Color(0xFFAA6EEB), Color(0xFFF054DC)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          border: Border.all(
            color: Color(0xFF111724),
            width: 2, // 2px de largeur
          ),
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: pickImage,
        ),
      );
  }
}