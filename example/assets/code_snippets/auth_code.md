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
          if (pin != null && pin != '000000' && pin.length == 6) {
            return 'The input must be exactly "000000".';
          } else {
            return null;
          }
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