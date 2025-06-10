import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class FilePickerButton extends StatelessWidget {
  final IconData icon;
  final Function(File file) onFileSelected;

  const FilePickerButton({
    super.key,
    required this.icon,
     required this.onFileSelected
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
            final bytes = result.files.single.bytes!;
            final fileName = result.files.single.name;
            // Create a File object from bytes for web
            final file = File.fromRawPath(bytes);
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image sélectionnée: $fileName')),
            );
            onFileSelected(file);
          } else {
            // Handle native platforms
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image sélectionnée: ${result.files.single.name}')),
            );
            final file = File(result.files.single.path!);
             onFileSelected(file);
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
            width: 2,
          ),
        ),
        child: IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: pickImage,
        ),
      );
  }
}