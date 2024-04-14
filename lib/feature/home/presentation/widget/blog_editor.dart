import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  const BlogEditor(
      {super.key,
      required this.hint,
      required this.controller,
      required this.type,
      required this.formKey});
  final String hint;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final BlogEditorType type;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        onFieldSubmitted: (value) => formKey.currentState!.validate(),
        onEditingComplete: () => formKey.currentState!.validate(),
        onSaved: (newValue) => formKey.currentState!.validate(),
        onTapOutside: (event) {
          formKey.currentState!.validate();
          FocusScope.of(context).unfocus();
        },
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
      ),
    );
  }
}

enum BlogEditorType { content, title }
