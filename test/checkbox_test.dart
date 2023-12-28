import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("cehckbox_test");

  testWidgets(
    "Provided key is used",
    (tester) async {
      await tester.pumpWidget(
        const TestWidget(
          widgetKey: key,
        ),
      );
      expect(find.byKey(key), findsOneWidget);
    },
  );

  testWidgets(
    "Change checkbox value",
    (tester) async {
      bool? checkboxValue = false;
      await tester.pumpWidget(
        TestWidget(
          widgetKey: key,
          onChanged: (newValue) => checkboxValue = newValue,
        ),
      );
      final checkbox = find.byKey(key);
      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      expect(checkboxValue, true);

      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      expect(checkboxValue, false);
    },
  );

  testWidgets(
    "Change tristate checkbox value",
    (tester) async {
      bool? checkboxValue = false;
      await tester.pumpWidget(
        TestWidget(
          widgetKey: key,
          isTristate: true,
          onChanged: (newValue) => checkboxValue = newValue,
        ),
      );
      final checkbox = find.byKey(key);
      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      expect(checkboxValue, true);

      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      expect(checkboxValue, null);

      await tester.tap(checkbox);
      await tester.pumpAndSettle();
      expect(checkboxValue, false);
    },
  );

  testWidgets(
    "Check checkbox label",
    (tester) async {
      const label = 'Checkbox label';

      await tester.pumpWidget(
        const TestWidget(
          widgetKey: key,
          label: label,
        ),
      );

      expect(find.text(label), findsOneWidget);
    },
  );
}

class TestWidget extends StatefulWidget {
  final Key? widgetKey;
  final void Function(bool?)? onChanged;
  final bool isTristate;
  final bool initialValue;
  final String? label;

  const TestWidget({
    super.key,
    this.widgetKey,
    this.isTristate = false,
    this.onChanged,
    this.initialValue = false,
    this.label,
  });

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  bool? checkboxValue;

  @override
  void initState() {
    super.initState();
    checkboxValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.label != null
            ? MoonCheckbox.withLabel(
                context,
                key: widget.widgetKey,
                value: checkboxValue,
                tristate: widget.isTristate,
                onChanged: (bool? newValue) {
                  setState(() => checkboxValue = newValue);
                  widget.onChanged?.call(newValue);
                },
                label: widget.label!,
              )
            : MoonCheckbox(
                key: widget.widgetKey,
                value: checkboxValue,
                tristate: widget.isTristate,
                onChanged: (bool? newValue) {
                  setState(() => checkboxValue = newValue);
                  widget.onChanged?.call(newValue);
                },
              ),
      ),
    );
  }
}
