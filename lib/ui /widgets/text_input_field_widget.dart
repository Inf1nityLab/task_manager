import 'package:flutter/material.dart';

class TextInputFieldWidget extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextEditingController controller;

  const TextInputFieldWidget(
      {super.key, required this.label, required this.hint, this.maxLines = 1, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        Text(label),
        SizedBox(height: 10,),
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              //borderSide: BorderSide.none
            ),

          ),
        ),

      ],
    );
  }
}
