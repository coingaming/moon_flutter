import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class InputGroup extends StatefulWidget {
  const InputGroup({super.key});

  @override
  State<InputGroup> createState() => _InputGroupState();
}

class _InputGroupState extends State<InputGroup> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              MoonInputGroup(
                children: [
                  MoonInput.form(
                    inputSize: MoonInputSize.xl,
                    controller: _textController,
                    validator: (String? value) => value?.length != null && value!.length < 5
                      ? "The text should be longer than 5 characters."
                      : null,
                    leading: const Icon(MoonIcons.generic_search_24_light),
                    trailing: GestureDetector(
                      onTap: () => _textController.clear(),
                      child: const Icon(MoonIcons.controls_close_small_24_light),
                    ),
                  ),
                  MoonInput.form(
                    inputSize: MoonInputSize.xl,
                    obscureText: _hidePassword,
                    controller: _passwordController,
                    validator: (String? value) => value != "123" ? "Wrong password." : null,
                    leading: const Icon(MoonIcons.security_password_24_light),
                    trailing: GestureDetector(
                      onTap: () => setState(() => _hidePassword = !_hidePassword),
                      child: Align(
                        child: Text(_hidePassword ? "Show" : "Hide"),
                      ),
                    ),
                  ),
                ],
              ),
              MoonFilledButton(
                onTap: () => Form.of(context).validate(),
                label: const Text("Submit"),
              ),
            ],
          );
        },
      ),
    );
  }
}