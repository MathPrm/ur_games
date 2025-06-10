import 'package:flutter/material.dart';
import '../style.dart';

class TextInput extends StatelessWidget {
  final TextEditingController _controller;
  final String label;
  final bool obscureText;

  const TextInput({
    super.key,
    required TextEditingController controller,
    required this.label,
     this.obscureText = false,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 24.0,
        right: 24.0,
      ),
      child: TextField(
        controller: _controller,
        decoration: textInput.copyWith(labelText: label),
        obscureText: obscureText,
      ),
    );
  }
}