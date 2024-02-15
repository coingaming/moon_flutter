import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("text_input_test");

  Future<void> submit(WidgetTester tester) async {
    await tester.tap(find.byType(MoonFilledButton));
    await tester.pumpAndSettle();
  }

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MoonFormTextInput && widget.key == key,
      ),
      findsOneWidget,
    );
  });

  testWidgets("Enter valid text", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    final textInput = find.byKey(key);

    await tester.enterText(textInput, validText);
    await tester.pumpAndSettle();
    expect(
      find.text(validText),
      findsOneWidget,
    );
    await submit(tester);
    expect(
      find.text(error),
      findsNothing,
    );
  });

  testWidgets("Enter invalid text", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    final textInput = find.byKey(key);

    await tester.enterText(textInput, invalidText);
    await tester.pumpAndSettle();
    expect(
      find.text(invalidText),
      findsOneWidget,
    );
    await submit(tester);
    expect(
      find.text(error),
      findsOneWidget,
    );
  });

  testWidgets("Check helper text", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        showHelper: true,
      ),
    );

    expect(
      find.text(helper),
      findsOneWidget,
    );
  });

  testWidgets("Check hint", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        showHelper: true,
      ),
    );

    expect(
      find.text(hint),
      findsOneWidget,
    );
  });
  testWidgets("Check leading, traling", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        showLeading: true,
        showTrailing: true,
      ),
    );

    expect(find.byIcon(leadingIcon), findsOneWidget);
    expect(find.byIcon(trailingIcon), findsOneWidget);
  });

  testWidgets("Disabled: enter text", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        enabled: false,
      ),
    );

    final textArea = find.byKey(key);

    await tester.enterText(textArea, validText);
    await tester.pumpAndSettle();
    expect(
      find.text(validText),
      findsNothing,
    );
  });
}

const validText = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry';
const invalidText = 'Lorem';

const hint = 'Hint';
const error = 'Error';
const helper = 'Helper';
const IconData leadingIcon = MoonIcons.other_frame_24_light;
const IconData trailingIcon = MoonIcons.controls_close_small_24_light;

class TestWidget extends StatelessWidget {
  final bool enabled;
  final bool showHelper;
  final Key? widgetKey;
  final bool showLeading;
  final bool showTrailing;

  const TestWidget({
    super.key,
    this.enabled = true,
    this.showHelper = false,
    this.widgetKey,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  MoonFormTextInput(
                    key: widgetKey,
                    enabled: enabled,
                    hintText: hint,
                    validator: (String? value) => value != null && value.length < 10 ? error : null,
                    leading: showLeading ? const Icon(leadingIcon) : null,
                    trailing: showTrailing ? const Icon(trailingIcon) : null,
                    helper: showHelper ? const Text(helper) : null,
                  ),
                  const SizedBox(height: 32),
                  MoonFilledButton(
                    label: const Text("Submit"),
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
