import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ur_games/pages/add_game.dart';
import '../widget/header.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final _supabase = Supabase.instance.client;
  List<dynamic> games = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  // Fonction pour récupérer les jeux depuis Supabase
  Future<void> _fetchGames() async {
    try {
      final response = await _supabase
          .from('library')
          .select('game_name, game_description'); // Récupère le nom et la description
      
      setState(() {
        games = response;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Erreur lors de la récupération des jeux: $error');
    }
  }

  // Fonction pour filtrer les jeux selon la recherche
  List<dynamic> get filteredGames {
    if (searchQuery.isEmpty) {
      return games;
    }
    return games.where((game) => 
      game['game_name'].toString().toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1320),
      body: SafeArea(
        child: Column(
          children: [
            Header(namePage: "BIBLIOTHEQUE"),

            // Barre de recherche
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Rechercher',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),

            // Bouton trier
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.sort, color: Colors.white),
                  const SizedBox(width: 4),
                  Text("Trier par :", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),

            // Grille de jeux
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredGames.isEmpty
                        ? const Center(
                            child: Text(
                              'Aucun jeu trouvé',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : GridView.builder(
                            itemCount: filteredGames.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.65,
                            ),
                            itemBuilder: (context, index) {
                              final game = filteredGames[index];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[800],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Titre du jeu
                                      Text(
                                        game['game_name'] ?? 'Nom indisponible',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      // Description du jeu
                                      Text(
                                        game['game_description'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
      ),

      // Floating Add Button
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.6, 1.0],
            colors: [
              Color(0xFF6289FB),
              Color(0xFFAA6EEB),
              Color(0xFFF054DC),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Color(0xFF111724),
            width: 2,
          ),
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddGame()),
            );
          },
        ),
      ),
    );
  }
}