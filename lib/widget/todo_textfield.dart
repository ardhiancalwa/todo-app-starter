import 'package:flutter/material.dart';

class TodoTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputAction? inputAction;
  final int maxLines;

  const TodoTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.inputAction,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      textInputAction: inputAction,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
