import 'package:flutter/material.dart';
import '../widget/header.dart';

class Friend extends StatelessWidget {
  const Friend({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
    child: Header(namePage:"MON AMI"),
    );
  }
}