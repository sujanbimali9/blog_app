import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  const BlogEditor(
      {super.key,
      required this.hint,
      required this.controller,
      required this.type});
  final String hint;
  final TextEditingController controller;
  final BlogEditorType type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hint is missing";
        }

        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
      ),
      expands: false,
      maxLines: type == BlogEditorType.title ? 1 : null,
    );
  }
}

enum BlogEditorType { content, title }
