import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _textAreaKey = Key("textAreaKey");
const Key _submitButtonKey = Key("submitButtonKey");

const String _hintText = 'Hint text';
const String _errorText = 'Error text';
const String _helperText = 'Helper text';
const String _validText = 'Valid text';
const String _invalidText = 'Invalid text';

void main() {
  Future<void> submit(WidgetTester tester) async {
    await tester.tap(find.byKey(_submitButtonKey));
    await tester.pumpAndSettle();
  }

  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _TextAreaTestWidget(
        textAreaKey: _textAreaKey,
      ),
    );

    expect(find.byKey(_textAreaKey), findsOneWidget);
  });

  testWidgets("When valid text is entered and submitted, error is not shown.", (tester) async {
    await tester.pumpWidget(
      const _TextAreaTestWidget(
        textAreaKey: _textAreaKey,
      ),
    );
    final textArea = find.byKey(_textAreaKey);

    await tester.enterText(textArea, _validText);
    await tester.pumpAndSettle();

    expect(find.text(_validText), findsOneWidget);

    await submit(tester);

    expect(find.text(_errorText), findsNothing);
  });

  testWidgets("When invalid text is entered and submitted, error is shown.", (tester) async {
    await tester.pumpWidget(
      const _TextAreaTestWidget(
        textAreaKey: _textAreaKey,
      ),
    );
    final textArea = find.byKey(_textAreaKey);

    await tester.enterText(textArea, _invalidText);
    await tester.pumpAndSettle();

    expect(find.text(_invalidText), findsOneWidget);

    await submit(tester);

    expect(find.text(_errorText), findsOneWidget);
  });

  testWidgets("Helper text is shown.", (tester) async {
    await tester.pumpWidget(
      const _TextAreaTestWidget(
        showHelper: true,
      ),
    );

    expect(find.text(_helperText), findsOneWidget);
  });

  testWidgets("Hint text is shown.", (tester) async {
    await tester.pumpWidget(
      const _TextAreaTestWidget(
        showHelper: true,
      ),
    );

    expect(find.text(_hintText), findsOneWidget);
  });

  testWidgets("When text area is disabled, input cannot be entered.", (tester) async {
    await tester.pumpWidget(
      const _TextAreaTestWidget(
        textAreaKey: _textAreaKey,
        enabled: false,
      ),
    );

    final textArea = find.byKey(_textAreaKey);

    await tester.enterText(textArea, _validText);
    await tester.pumpAndSettle();

    expect(find.text(_validText), findsNothing);
  });
}

class _TextAreaTestWidget extends StatelessWidget {
  final Key? textAreaKey;
  final bool enabled;
  final bool showHelper;

  const _TextAreaTestWidget({
    this.textAreaKey,
    this.enabled = true,
    this.showHelper = false,
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
                  MoonTextArea(
                    key: textAreaKey,
                    enabled: enabled,
                    hintText: _hintText,
                    validator: (String? value) => value?.length != null && value!.length > 10 ? _errorText : null,
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
