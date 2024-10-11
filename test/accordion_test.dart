import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

enum _AccordionItems { first, second }

const Key _accordionKey = Key("accordionKey");
const Key _firstAccordionKey = Key("firstAccordionKey");
const Key _firstAccordionChildKey = Key("firstAccordionChildKey");
const Key _secondAccordionKey = Key("secondAccordionKey");
const Key _secondAccordionChildKey = Key("secondAccordionChildKey");

const String _accordionLabel = "Label";
const String _accordionContent = "Content";
const IconData _accordionTrailingIcon = MoonIcons.other_frame_24_light;

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _AccordionTestWidget(
        accordionKey: _accordionKey,
      ),
    );

    expect(find.byKey(_accordionKey), findsOneWidget);
  });

  group('Single accordion', () {
    testWidgets("Accordion expands when tapped.", (tester) async {
      await tester.pumpWidget(const _SingleAccordionTestWidget());
      final accordion = find.byKey(_firstAccordionKey);
      final child = find.byKey(_firstAccordionChildKey);

      expect(accordion, findsOneWidget);
      expect(child, findsNothing);
      expect(find.text(_accordionLabel), findsOneWidget);
      expect(find.byIcon(_accordionTrailingIcon), findsOneWidget);

      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(child, findsOneWidget);
      expect(find.text(_accordionContent), findsOneWidget);
    });

    testWidgets("Disabled accordion does not expand when tapped.",
        (tester) async {
      await tester.pumpWidget(
        const _SingleAccordionTestWidget(
          isDisabled: true,
        ),
      );
      final accordion = find.byKey(_firstAccordionKey);
      final child = find.byKey(_firstAccordionChildKey);

      expect(accordion, findsOneWidget);
      expect(child, findsNothing);

      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(child, findsNothing);
    });
  });

  group('Grouped accordion', () {
    testWidgets("First accordion collapses when second accordion expands.",
        (tester) async {
      await tester.pumpWidget(const _GroupedAccordionTestWidget());
      // First accordion.
      final accordion1 = find.byKey(_firstAccordionKey);
      final child1 = find.byKey(_firstAccordionChildKey);
      // Second accordion.
      final accordion2 = find.byKey(_secondAccordionKey);
      final child2 = find.byKey(_secondAccordionChildKey);

      // Initially, the first accordion is expanded.
      expect(accordion1, findsOneWidget);
      expect(accordion2, findsOneWidget);
      expect(child1, findsOneWidget);
      expect(child2, findsNothing);

      // Tap on the second accordion to expand it and collapse the first one.
      await tester.tap(accordion2);
      await tester.pumpAndSettle();

      expect(child2, findsOneWidget);
      expect(child1, findsNothing);

      // Tap on the second accordion again to collapse it.
      await tester.tap(accordion2);
      await tester.pumpAndSettle();

      expect(child2, findsNothing);
      expect(child1, findsNothing);
    });
  });
}

class _AccordionTestWidget extends StatelessWidget {
  final Key? accordionKey;

  const _AccordionTestWidget({this.accordionKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonAccordion<_AccordionItems>(
          key: accordionKey,
          label: const Text(_accordionLabel),
        ),
      ),
    );
  }
}

class _SingleAccordionTestWidget extends StatelessWidget {
  final bool isDisabled;

  const _SingleAccordionTestWidget({this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonAccordion<_AccordionItems>(
          key: _firstAccordionKey,
          isDisabled: isDisabled,
          leading: const Icon(_accordionTrailingIcon),
          label: const Text(_accordionLabel),
          children: const [
            Text(
              key: _firstAccordionChildKey,
              _accordionContent,
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupedAccordionTestWidget extends StatefulWidget {
  const _GroupedAccordionTestWidget();

  @override
  State<_GroupedAccordionTestWidget> createState() =>
      _GroupedAccordionTestWidgetState();
}

class _GroupedAccordionTestWidgetState
    extends State<_GroupedAccordionTestWidget> {
  _AccordionItems? _currentlyOpenAccordionItem = _AccordionItems.first;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            MoonAccordion<_AccordionItems>(
              key: _firstAccordionKey,
              identityValue: _AccordionItems.first,
              groupIdentityValue: _currentlyOpenAccordionItem,
              onExpansionChanged: (_AccordionItems? value) =>
                  setState(() => _currentlyOpenAccordionItem = value),
              leading: const Icon(MoonIcons.other_frame_24_light),
              label: const Text("Grouped MoonAccordion item #1"),
              children: const [
                Text(
                  key: _firstAccordionChildKey,
                  _accordionContent,
                ),
              ],
            ),
            MoonAccordion<_AccordionItems>(
              key: _secondAccordionKey,
              identityValue: _AccordionItems.second,
              groupIdentityValue: _currentlyOpenAccordionItem,
              onExpansionChanged: (_AccordionItems? value) =>
                  setState(() => _currentlyOpenAccordionItem = value),
              leading: const Icon(MoonIcons.other_frame_24_light),
              label: const Text("Grouped MoonAccordion item #2"),
              children: const [
                Text(
                  key: _secondAccordionChildKey,
                  _accordionContent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
