import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class AuthCode extends StatelessWidget {
  const AuthCode({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95, // To avoid widget jumping with error text, use a fixed-height wrapper.
      child: MoonAuthCode(
        validator: (String? pin) {
          // Matches all numbers.
          final RegExp regex = RegExp(r'^\d+$');

          return pin != null && pin.length == 4 && !regex.hasMatch(pin)
            ? 'The input must only contain numbers'
            : null;
        },
        errorBuilder: (BuildContext context, String? errorText) {
          return Align(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(errorText ?? ''),
            ),
          );
        },
      ),
    );
  }
}