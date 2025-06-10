import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widget/header.dart';
import 'add_friend.dart';
import './friend.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  List<Map<String, dynamic>> friends = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    final response = await Supabase.instance.client
        .from('friendlist')
        .select('*');
    setState(() {
      friends = List<Map<String, dynamic>>.from(response);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232B3E),
      body: Column(
        children: [
          const Header(namePage: "MA LISTE D'AMI"),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        child: FriendCard(
                          name: friend['friend_name'] ?? 'Inconnu',
                          avatarUrl: friend['avatarUrl'] ?? 'assets/default.png',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Friend()),
          );
        },
        child: const Icon(Icons.person_add),
        backgroundColor: const Color(0xFF5E6BAA),
      ),
    );
  }
}

class FriendCard extends StatelessWidget {
  final String name;
  final String avatarUrl;

  const FriendCard({super.key, required this.name, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4B5676),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundImage: AssetImage(avatarUrl),
          radius: 28,
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
