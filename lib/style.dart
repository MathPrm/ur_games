import 'package:flutter/material.dart';

const textInput = InputDecoration(
  border: OutlineInputBorder(),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF6379A7), width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFF054DC), width: 2.0),
  ),
  labelStyle: TextStyle(
    color: Color(0xFF455678),
    fontSize: 18.0,
    backgroundColor: Color(0xFFEAEDF5),
  ),
  filled: true,
  fillColor: Color(0xFFEAEDF5),
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  
);

const primaryButtonText = TextStyle(
  fontSize: 18.0,
  color: Color(0xFFEAEDF5)
);

// ...existing code...

Container formContainer({required Widget child}) => Container(
  margin: const EdgeInsets.all(20),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: const Color(0xFF455678),
    borderRadius: BorderRadius.circular(15),
  ),
  constraints: const BoxConstraints(maxWidth: 400),
  child: child,
);

const inputIcon = IconThemeData(
  color: Color(0xFF455678),
);