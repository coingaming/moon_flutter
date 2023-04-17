import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class MoonTextArea extends StatelessWidget {
  final String? hintText;

  const MoonTextArea({
    super.key,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: TextField(
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        enabled: false,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: SmoothBorderRadius.all(
                  SmoothRadius(cornerRadius: 8, cornerSmoothing: 1))), // Adds a border around the TextField
        ),
      ),
    );
  }
}
