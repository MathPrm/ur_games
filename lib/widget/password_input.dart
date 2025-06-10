import 'package:flutter/material.dart';
import '../style.dart';

class PassInput extends StatefulWidget {
  final TextEditingController _controller;
  final String label;

  const PassInput({
    super.key,
    required TextEditingController controller,
    required this.label,
  }) : _controller = controller;

  @override
  State<PassInput> createState() => _PassInputState();
}

class _PassInputState extends State<PassInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 24.0,
        right: 24.0,
      ),
      child: TextField(
        controller: widget._controller,
        decoration: textInput.copyWith(
          labelText: widget.label,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: inputIcon.color,
            ),
          ),
        ),
        obscureText: _obscureText,
      ),
    );
  }
}