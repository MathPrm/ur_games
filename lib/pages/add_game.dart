import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../widget/header.dart';

class AddGame extends StatefulWidget {
  const AddGame({super.key});

  @override
  State<AddGame> createState() => _AddGameState();
}

class _AddGameState extends State<AddGame> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  File? _selectedImage;

  final List<String> _categories = [
    'Aventure',
    'RPG',
    'Multijoueur',
    'FPS',
    'Sport',
    'Simulation'
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1320),
      body: SafeArea(
        // Header(namePage:"MON AMI"),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'AJOUTER UN JEU',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Titre
              const Text("Titre :", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 4),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Titre du jeu',
                ),
              ),
              const SizedBox(height: 16),

              // Description
              const Text("Description :", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 4),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Description du jeu',
                ),
              ),
              const SizedBox(height: 16),

              // Image picker
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: _selectedImage == null
                        ? const Icon(Icons.image, size: 50)
                        : Image.file(_selectedImage!, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Ajouter une image :", style: TextStyle(color: Colors.white)),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.6, 1.0],
                              colors: [
                                Color(0xFF6289FB),
                                Color(0xFFAA6EEB),
                                Color(0xFFF054DC),
                              ],
                            ),
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Dropdown
              const Text("Ajouter à une catégorie :", style: TextStyle(color: Colors.white)),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1E2431),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: _selectedCategory,
                hint: const Text('Sélectionner une catégorie'),
                onChanged: (val) {
                  setState(() {
                    _selectedCategory = val;
                  });
                },
                items: _categories
                    .map((category) =>
                        DropdownMenuItem(value: category, child: Text(category)))
                    .toList(),
              ),
              const SizedBox(height: 24),

              // Enregistrer button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF054DC),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  // TODO: Ajouter à la BDD
                },
                icon: const Icon(Icons.save),
                label: const Text("ENREGISTRER"),
              ),
              const SizedBox(height: 12),

              // Wishlist
              Center(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Ajouter à la wishlist
                  },
                  icon: const Icon(Icons.favorite_border, color: Color(0xFFF054DC)),
                  label: const Text(
                    'Wishlist',
                    style: TextStyle(color: Color(0xFFF054DC)),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFF054DC)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
