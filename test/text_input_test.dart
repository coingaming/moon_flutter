import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _textInputKey = Key("textInputKey");
const Key _submitButtonKey = Key("submitButtonKey");

const String _hintText = 'Hint text';
const String _errorText = 'Error text';
const String _helperText = 'Helper text';
const String _validText = 'Valid text';
const String _invalidText = 'Invalid text';
const IconData _textInputLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _textInputTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  Future<void> submit(WidgetTester tester) async {
    await tester.tap(find.byKey(_submitButtonKey));
    await tester.pumpAndSettle();
  }

  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _TextInputTestWidget(
        textInputKey: _textInputKey,
      ),
    );

    expect(find.byKey(_textInputKey), findsOneWidget);
  });

  testWidgets("When valid text is entered and submitted, error is not shown.", (tester) async {
    await tester.pumpWidget(
      const _TextInputTestWidget(
        textInputKey: _textInputKey,
      ),
    );
    final textInput = find.byKey(_textInputKey);

    await tester.enterText(textInput, _validText);
    await tester.pumpAndSettle();

    expect(find.text(_validText), findsOneWidget);

    await submit(tester);

    expect(find.text(_errorText), findsNothing);
  });

  testWidgets("When invalid text is entered and submitted, error is shown.", (tester) async {
    await tester.pumpWidget(
      const _TextInputTestWidget(
        textInputKey: _textInputKey,
      ),
    );
    final textInput = find.byKey(_textInputKey);

    await tester.enterText(textInput, _invalidText);
    await tester.pumpAndSettle();

    expect(find.text(_invalidText), findsOneWidget);

    await submit(tester);

    expect(find.text(_errorText), findsOneWidget);
  });

  testWidgets("Helper text is shown.", (tester) async {
    await tester.pumpWidget(
      const _TextInputTestWidget(
        showHelper: true,
      ),
    );

    expect(find.text(_helperText), findsOneWidget);
  });

  testWidgets("Hint text is shown.", (tester) async {
    await tester.pumpWidget(
      const _TextInputTestWidget(
        showHelper: true,
      ),
    );

    expect(find.text(_hintText), findsOneWidget);
  });

  testWidgets("Text input has a leading and trailing widget.", (tester) async {
    await tester.pumpWidget(
      const _TextInputTestWidget(
        showLeading: true,
        showTrailing: true,
      ),
    );

    expect(find.byIcon(_textInputLeadingIcon), findsOneWidget);
    expect(find.byIcon(_textInputTrailingIcon), findsOneWidget);
  });

  testWidgets("When text input is disabled, input cannot be entered.", (tester) async {
    await tester.pumpWidget(
      const _TextInputTestWidget(
        textInputKey: _textInputKey,
        enabled: false,
      ),
    );

    final textArea = find.byKey(_textInputKey);

    await tester.enterText(textArea, _validText);
    await tester.pumpAndSettle();

    expect(find.text(_validText), findsNothing);
  });
}

class _TextInputTestWidget extends StatelessWidget {
  final Key? textInputKey;
  final bool enabled;
  final bool showHelper;
  final bool showLeading;
  final bool showTrailing;

  const _TextInputTestWidget({
    this.textInputKey,
    this.enabled = true,
    this.showHelper = false,
    this.showLeading = false,
    this.showTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Form(
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  MoonFormTextInput(
                    key: textInputKey,
                    enabled: enabled,
                    hintText: _hintText,
                    validator: (String? value) => value != null && value.length > 10 ? _errorText : null,
                    leading: showLeading ? const Icon(_textInputLeadingIcon) : null,
                    trailing: showTrailing ? const Icon(_textInputTrailingIcon) : null,
                    helper: showHelper ? const Text(_helperText) : null,
                  ),
                  MoonFilledButton(
                    key: _submitButtonKey,
                    onTap: () => Form.of(context).validate(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
