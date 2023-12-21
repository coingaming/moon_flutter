import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class TextInput extends StatefulWidget {
  const TextInput({super.key});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              MoonFormTextInput(
                controller: _textController,
                validator: (String? value) => value != null && value.length < 5 
                  ? "The text should be longer than 5 characters." 
                  : null,
                onTap: () => _textController.clear(),
                leading: const Icon(MoonIcons.generic_search_24_light),
                trailing: GestureDetector(
                  child: const Icon(MoonIcons.controls_close_small_24_light),
                ),
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