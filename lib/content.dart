import 'package:flutter/material.dart';
import 'package:ur_games/pages/edit_profile_page.dart';
import 'package:ur_games/pages/login_page.dart';
import 'package:ur_games/pages/wish_list.dart';
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
    FriendsList()
  ];

  final List<IconData> _icons = [
    Icons.person,
    Icons.favorite_border,
    Icons.grid_view,
    Icons.groups,
    Icons.logout
  ];

  int _currentScreen = 0;

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
                      if (i == _icons.length - 1) { // Logout icon
                        _authService.signOut().then((_) {
                          // Navigate to login page after logout
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        });
                      } else {
                        setState(() {
                          _currentScreen = i;
                        });
                      }
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
