import 'package:flutter/material.dart';
import '../widget/header.dart';


class FriendsList extends StatelessWidget {
  const FriendsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
    child: Header(namePage:"MA LISTE D'AMI"),
    );
  }
}