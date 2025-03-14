import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _inputKey = Key("inputKey");
const Key _submitButtonKey = Key("submitButtonKey");

const String _hintText = 'Hint text';
const String _errorText = 'Error text';
const String _helperText = 'Helper text';
const String _validText = 'Valid text';
const String _invalidText = 'Invalid text';
const IconData _inputLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _inputTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  Future<void> submit(WidgetTester tester) async {
    await tester.tap(find.byKey(_submitButtonKey));
    await tester.pumpAndSettle();
  }

  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _InputTestWidget(
        inputKey: _inputKey,
      ),
    );

    expect(find.byKey(_inputKey), findsOneWidget);
  });

  testWidgets("When valid text is entered and submitted, error is not shown.",
      (tester) async {
    await tester.pumpWidget(
      const _InputTestWidget(
        inputKey: _inputKey,
      ),
    );
    final input = find.byKey(_inputKey);

    await tester.enterText(input, _validText);
    await tester.pumpAndSettle();

    expect(find.text(_validText), findsOneWidget);

    await submit(tester);

    expect(find.text(_errorText), findsNothing);
  });

  testWidgets("When invalid text is entered and submitted, error is shown.",
      (tester) async {
    await tester.pumpWidget(
      const _InputTestWidget(
        inputKey: _inputKey,
      ),
    );
    final input = find.byKey(_inputKey);

    await tester.enterText(input, _invalidText);
    await tester.pumpAndSettle();

    expect(find.text(_invalidText), findsOneWidget);

    await submit(tester);

    expect(find.text(_errorText), findsOneWidget);
  });

  testWidgets("Helper text is shown.", (tester) async {
    await tester.pumpWidget(
      const _InputTestWidget(
        showHelper: true,
      ),
    );

    expect(find.text(_helperText), findsOneWidget);
  });

  testWidgets("Hint text is shown.", (tester) async {
    await tester.pumpWidget(
      const _InputTestWidget(
        showHelper: true,
      ),
    );

    expect(find.text(_hintText), findsOneWidget);
  });

  testWidgets("Input has a leading and trailing widget.", (tester) async {
    await tester.pumpWidget(
      const _InputTestWidget(
        showLeading: true,
        showTrailing: true,
      ),
    );

    expect(find.byIcon(_inputLeadingIcon), findsOneWidget);
    expect(find.byIcon(_inputTrailingIcon), findsOneWidget);
  });

  testWidgets("When input is disabled, text cannot be entered.",
      (tester) async {
    await tester.pumpWidget(
      const _InputTestWidget(
        inputKey: _inputKey,
        enabled: false,
      ),
    );

    final textArea = find.byKey(_inputKey);

    await tester.enterText(textArea, _validText);
    await tester.pumpAndSettle();

    expect(find.text(_validText), findsNothing);
  });
}

class _InputTestWidget extends StatelessWidget {
  final Key? inputKey;
  final bool enabled;
  final bool showHelper;
  final bool showLeading;
  final bool showTrailing;

  const _InputTestWidget({
    this.inputKey,
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
                  MoonInput.form(
                    key: inputKey,
                    enabled: enabled,
                    hintText: _hintText,
                    validator: (String? value) =>
                        value != null && value.length > 10 ? _errorText : null,
                    leading: showLeading ? const Icon(_inputLeadingIcon) : null,
                    trailing:
                        showTrailing ? const Icon(_inputTrailingIcon) : null,
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
