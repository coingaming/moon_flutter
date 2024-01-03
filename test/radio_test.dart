import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

enum Choice { first, second }

void main() {
  const firstKey = Key("first_radio_test");
  const secondKey = Key("second_radio_test");

  Finder findSelecterFirstRadio() {
    return find.byWidgetPredicate(
      (widget) =>
          widget is MoonRadio &&
          widget.key == firstKey &&
          widget.value == Choice.first &&
          widget.groupValue == Choice.first,
    );
  }

  Finder findSelecterSecondRadio() {
    return find.byWidgetPredicate(
      (widget) =>
          widget is MoonRadio &&
          widget.key == secondKey &&
          widget.value == Choice.second &&
          widget.groupValue == Choice.second,
    );
  }

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestRadioWidget(
        firstRadioKey: firstKey,
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MoonRadio && widget.key == firstKey,
      ),
      findsOneWidget,
    );
  });

  testWidgets("Test radio with label", (tester) async {
    await tester.pumpWidget(
      const TestRadioWithLabelWidget(),
    );

    expect(find.text(label1), findsOneWidget);
    expect(find.text(label2), findsOneWidget);
  });

  testWidgets("Test radio switch", (tester) async {
    await tester.pumpWidget(
      const TestRadioWidget(
        firstRadioKey: firstKey,
        secondRadioKey: secondKey,
      ),
    );

    await tester.tap(find.byKey(firstKey));
    await tester.pumpAndSettle();

    expect(
      findSelecterFirstRadio(),
      findsOneWidget,
    );

    await tester.tap(find.byKey(secondKey));
    await tester.pumpAndSettle();
    expect(findSelecterFirstRadio(), findsNothing);
    expect(findSelecterSecondRadio(), findsOneWidget);
    await tester.tap(find.byKey(secondKey));
    await tester.pumpAndSettle();
    expect(findSelecterFirstRadio(), findsNothing);
    expect(findSelecterSecondRadio(), findsOneWidget);
  });

  testWidgets("Test toggable radio switch", (tester) async {
    await tester.pumpWidget(
      const TestRadioWidget(
        firstRadioKey: firstKey,
        secondRadioKey: secondKey,
        toggleable: true,
      ),
    );

    await tester.tap(find.byKey(firstKey));
    await tester.pumpAndSettle();

    expect(
      findSelecterFirstRadio(),
      findsOneWidget,
    );

    await tester.tap(find.byKey(secondKey));
    await tester.pumpAndSettle();
    expect(findSelecterFirstRadio(), findsNothing);
    expect(findSelecterSecondRadio(), findsOneWidget);
    await tester.tap(find.byKey(secondKey));
    await tester.pumpAndSettle();
    expect(findSelecterFirstRadio(), findsNothing);
    expect(findSelecterSecondRadio(), findsNothing);
  });
}

class TestRadioWidget extends StatefulWidget {
  final bool toggleable;

  final Key? firstRadioKey;
  final Key? secondRadioKey;
  const TestRadioWidget({
    super.key,
    this.toggleable = false,
    this.firstRadioKey,
    this.secondRadioKey,
  });
  @override
  State<TestRadioWidget> createState() => _TestRadioWidgetState();
}

class _TestRadioWidgetState extends State<TestRadioWidget> {
  Choice? value;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
            child: Column(
              children: [
                MoonRadio(
                  key: widget.firstRadioKey,
                  value: Choice.first,
                  groupValue: value,
                  onChanged: (Choice? choice) => setState(() => value = choice),
                  toggleable: widget.toggleable,
                ),
                const SizedBox(height: 8),
                MoonRadio(
                  value: Choice.second,
                  key: widget.secondRadioKey,
                  groupValue: value,
                  onChanged: (Choice? choice) => setState(() => value = choice),
                  toggleable: widget.toggleable,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const label1 = 'Label 1';
const label2 = 'Label 2';

class TestRadioWithLabelWidget extends StatefulWidget {
  const TestRadioWithLabelWidget({super.key});
  @override
  State<TestRadioWithLabelWidget> createState() =>
      _TestRadioWithLabelWidgetState();
}

class _TestRadioWithLabelWidgetState extends State<TestRadioWithLabelWidget> {
  Choice? value;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
            child: Column(
              children: [
                MoonRadio.withLabel(
                  context,
                  label: label1,
                  value: Choice.first,
                  groupValue: value,
                  onChanged: (Choice? choice) => setState(() => value = choice),
                ),
                const SizedBox(height: 8),
                MoonRadio.withLabel(
                  context,
                  value: Choice.second,
                  label: label2,
                  groupValue: value,
                  onChanged: (Choice? choice) => setState(() => value = choice),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
