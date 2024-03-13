import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

enum _Choice { first, second }

const Key _firstRadioKey = Key("firstRadioKey");
const Key _secondRadioKey = Key("secondRadioKey");

void main() {
  Finder findSelectorFirstRadio() {
    return find.byWidgetPredicate(
      (Widget widget) =>
          widget is MoonRadio &&
          widget.key == _firstRadioKey &&
          widget.value == _Choice.first &&
          widget.groupValue == _Choice.first,
    );
  }

  Finder findSelectorSecondRadio() {
    return find.byWidgetPredicate(
      (Widget widget) =>
          widget is MoonRadio &&
          widget.key == _secondRadioKey &&
          widget.value == _Choice.second &&
          widget.groupValue == _Choice.second,
    );
  }

  testWidgets("Provided keys are used.", (tester) async {
    await tester.pumpWidget(
      const _RadioTestWidget(
        firstRadioKey: _firstRadioKey,
        secondRadioKey: _secondRadioKey,
      ),
    );

    expect(find.byKey(_firstRadioKey), findsOneWidget);
    expect(find.byKey(_secondRadioKey), findsOneWidget);
  });

  testWidgets("The selection of radio buttons can be changed.", (tester) async {
    await tester.pumpWidget(
      const _RadioTestWidget(
        firstRadioKey: _firstRadioKey,
        secondRadioKey: _secondRadioKey,
      ),
    );

    await tester.tap(find.byKey(_firstRadioKey));
    await tester.pumpAndSettle();

    expect(findSelectorFirstRadio(), findsOneWidget);

    await tester.tap(find.byKey(_secondRadioKey));
    await tester.pumpAndSettle();

    expect(findSelectorFirstRadio(), findsNothing);
    expect(findSelectorSecondRadio(), findsOneWidget);

    await tester.tap(find.byKey(_firstRadioKey));
    await tester.pumpAndSettle();

    expect(findSelectorFirstRadio(), findsOneWidget);
    expect(findSelectorSecondRadio(), findsNothing);
  });

  testWidgets("Selected radio button can be unselected.", (tester) async {
    await tester.pumpWidget(
      const _RadioTestWidget(
        firstRadioKey: _firstRadioKey,
        secondRadioKey: _secondRadioKey,
        toggleable: true,
      ),
    );

    await tester.tap(find.byKey(_firstRadioKey));
    await tester.pumpAndSettle();

    expect(findSelectorFirstRadio(), findsOneWidget);

    await tester.tap(find.byKey(_secondRadioKey));
    await tester.pumpAndSettle();

    expect(findSelectorFirstRadio(), findsNothing);
    expect(findSelectorSecondRadio(), findsOneWidget);

    await tester.tap(find.byKey(_secondRadioKey));
    await tester.pumpAndSettle();

    expect(findSelectorFirstRadio(), findsNothing);
    expect(findSelectorSecondRadio(), findsNothing);
  });
}

class _RadioTestWidget extends StatefulWidget {
  final bool toggleable;
  final Key? firstRadioKey;
  final Key? secondRadioKey;

  const _RadioTestWidget({
    this.firstRadioKey,
    this.secondRadioKey,
    this.toggleable = false,
  });

  @override
  State<_RadioTestWidget> createState() => _RadioTestWidgetState();
}

class _RadioTestWidgetState extends State<_RadioTestWidget> {
  _Choice? _value;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            MoonRadio(
              key: widget.firstRadioKey,
              toggleable: widget.toggleable,
              value: _Choice.first,
              groupValue: _value,
              onChanged: (_Choice? choice) => setState(() => _value = choice),
            ),
            const SizedBox(height: 8),
            MoonRadio(
              key: widget.secondRadioKey,
              toggleable: widget.toggleable,
              value: _Choice.second,
              groupValue: _value,
              onChanged: (_Choice? choice) => setState(() => _value = choice),
            ),
          ],
        ),
      ),
    );
  }
}
