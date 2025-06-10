import 'package:flutter/material.dart';

class Friend extends StatelessWidget {
  const Friend({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
    padding: EdgeInsets.all(10),
    child: Text('Friend'),
    );
  }
}