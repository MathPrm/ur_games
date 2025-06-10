import 'package:flutter/material.dart';
import 'package:ur_games/pages/edit_profile_page.dart';
import 'package:ur_games/pages/wish_list.dart';

// Remplace ces imports par les tiens
import 'pages/library.dart';
import 'pages/friends_list.dart';
// import 'pages/add_game.dart';
import 'auth/auth_service.dart';
final AuthService _authService = AuthService();

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final List<Widget> _screenList = const [
    EditProfilePage(),
    WishList(),
    Library(),
    FriendsList(),
  ];

  final List<IconData> _icons = [
    Icons.person,
    Icons.favorite_border,
    Icons.grid_view,
    Icons.groups,
  ];

  int _currentScreen = 0;
  bool _menuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFF2A354C),
          body: _screenList[_currentScreen],
          bottomNavigationBar: Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF111724),
              border: Border(
                top: BorderSide(color: Colors.black12, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < _icons.length; i++)
                  IconButton(
                    icon: Icon(
                      _icons[i],
                      color: _currentScreen == i
                          ? const Color(0xFFF054DC)
                          : Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentScreen = i;
                      });
                    },
                  ),
                // Bouton burger à droite
                GestureDetector(
                  onTap: () => setState(() => _menuOpen = true),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white12,
                    ),
                    child: const Center(
                      child: Icon(Icons.menu, color: Colors.white, size: 28),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Overlay du menu burger
        if (_menuOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => setState(() => _menuOpen = false),
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 350,
                      child: Stack(
                        children: [
                          ListView(
                            padding: const EdgeInsets.symmetric(
                                vertical: 32, horizontal: 16),
                            children: [
                              ListTile(
                                leading: const Icon(Icons.account_circle),
                                title: const Text('Profil'),
                                onTap: () {
                                  // Ajoute la navigation vers Profil ici
                                  setState(() {
                                    _menuOpen = false;
                                    // _currentScreen = ... si tu veux changer d'écran
                                  });
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.settings),
                                title: const Text('Settings'),
                                onTap: () {
                                  setState(() {
                                    _menuOpen = false;
                                  });
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.logout),
                                title: const Text('Déconnexion'),
                                onTap: () async {
                                  await _authService.signOut();
                                  setState(() {
                                    _menuOpen = false;
                                  });
                                },
                              ),
                              // Ajoute d'autres options ici
                            ],
                          ),
                          // Bouton croix pour fermer
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(Icons.close, size: 28, color: Colors.black),
                              onPressed: () => setState(() => _menuOpen = false),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
