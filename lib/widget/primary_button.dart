import 'package:flutter/material.dart';
import 'package:ur_games/style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Future<void> Function() function;
  

  const PrimaryButton({
    super.key,
    required this.text,
    required this.function,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        bottom: 16.0
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6289FB), Color(0xFFAA6EEB), Color(0xFFF054DC)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: MaterialButton(
          onPressed: function,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: 12.0,
              right: 12.0
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 8),
                ],
                Text(text, style: primaryButtonText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}