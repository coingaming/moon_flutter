import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _checkboxKey = Key("checkboxKey");

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _CheckboxTestWidget(
        checkboxKey: _checkboxKey,
      ),
    );

    expect(find.byKey(_checkboxKey), findsOneWidget);
  });

  testWidgets("Checkbox value changes after a tap.", (tester) async {
    bool? checkboxValue = false;

    await tester.pumpWidget(
      _CheckboxTestWidget(
        checkboxKey: _checkboxKey,
        onChanged: (bool? newValue) => checkboxValue = newValue,
      ),
    );
    final checkbox = find.byKey(_checkboxKey);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, true);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, false);
  });

  testWidgets("Tristate checkbox value changes correctly when tapped multiple times.", (tester) async {
    bool? checkboxValue = false;

    await tester.pumpWidget(
      _CheckboxTestWidget(
        checkboxKey: _checkboxKey,
        isTristate: true,
        onChanged: (newValue) => checkboxValue = newValue,
      ),
    );
    final checkbox = find.byKey(_checkboxKey);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, true);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, null);

    await tester.tap(checkbox);
    await tester.pumpAndSettle();

    expect(checkboxValue, false);
  });
}

class _CheckboxTestWidget extends StatefulWidget {
  final Key? checkboxKey;
  final bool isTristate;
  final void Function(bool?)? onChanged;

  const _CheckboxTestWidget({
    this.checkboxKey,
    this.isTristate = false,
    this.onChanged,
  });

  @override
  State<_CheckboxTestWidget> createState() => _CheckboxTestWidgetState();
}

class _CheckboxTestWidgetState extends State<_CheckboxTestWidget> {
  bool? _checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonCheckbox(
          key: widget.checkboxKey,
          value: _checkboxValue,
          tristate: widget.isTristate,
          onChanged: (bool? newValue) {
            setState(() => _checkboxValue = newValue);
            widget.onChanged?.call(newValue);
          },
        ),
      ),
    );
  }
}
