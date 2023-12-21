import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class AuthCode extends StatefulWidget {
  const AuthCode({super.key});

  @override
  State<AuthCode> createState() => _AuthCodeState();
}

class _AuthCodeState extends State<AuthCode> {
  late StreamController<ErrorAnimationType> _errorStreamController;

  @override
  void initState() {
    super.initState();

    _errorStreamController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    _errorStreamController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95, // To avoid widget jumping with error text, use a fixed-height wrapper.
      child: MoonAuthCode(
        errorStreamController: _errorStreamController,
        onCompleted: (String pin) {
          if (pin != '123456') {
            _errorStreamController.add(ErrorAnimationType.shake);
          }
        },
        validator: (String? pin) => pin?.length == 6 && pin != '123456'
          ? 'Invalid authentication code. Please try again.'
          : null,
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