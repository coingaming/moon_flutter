import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

enum AccordionItems { first, second }

void main() {
  const key = Key("accordion_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: MoonAccordion<AccordionItems>(
          key: key,
          label: const Text("Title"),
          children: [
            Container(),
          ],
        ),
      ),
    );
    expect(find.byKey(key), findsOneWidget);
  });

  group('Single accordion', () {
    testWidgets("Accordion expands after click", (tester) async {
      await tester.pumpWidget(
        const SingleAccordionTestWidget(),
      );
      final accordion = find.byKey(firstAccordionKey);
      final child = find.byKey(firstAccordionChildKey);

      expect(accordion, findsOneWidget);
      expect(child, findsNothing);
      expect(find.text(accordionTitle), findsOneWidget);
      expect(find.byIcon(accordionIcon), findsOneWidget);

      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(child, findsOneWidget);
      expect(find.text(accordionContent), findsOneWidget);
    });
    testWidgets("Disabled accordion not expands after click", (tester) async {
      await tester.pumpWidget(
        const SingleAccordionTestWidget(
          isDisabled: true,
        ),
      );
      final accordion = find.byKey(firstAccordionKey);
      final child = find.byKey(firstAccordionChildKey);

      expect(accordion, findsOneWidget);
      expect(child, findsNothing);

      await tester.tap(accordion);
      await tester.pumpAndSettle();

      expect(child, findsNothing);
    });
  });

  group('Grouped accordion', () {
    testWidgets("First accordion hides when second expands", (tester) async {
      await tester.pumpWidget(
        const GroupedAccordionTestWidget(),
      );
      final accordion1 = find.byKey(firstAccordionKey);
      final child1 = find.byKey(firstAccordionChildKey);

      final accordion2 = find.byKey(secondAccordionKey);
      final child2 = find.byKey(secondAccordionChildKey);

      //Initially first accordion is expanded
      expect(accordion1, findsOneWidget);
      expect(accordion2, findsOneWidget);
      expect(child1, findsOneWidget);
      expect(child2, findsNothing);

      //Tap on second accordion to expand it
      await tester.tap(accordion2);
      await tester.pumpAndSettle();

      expect(child2, findsOneWidget);
      expect(child1, findsNothing);

      //Tap on second accordion again to close it
      await tester.tap(accordion2);
      await tester.pumpAndSettle();

      expect(child2, findsNothing);
      expect(child1, findsNothing);
    });
  });
}

const String accordionTitle = "Single MoonAccordion item";
const String accordionContent = "Accordion content";
const IconData accordionIcon = MoonIcons.other_frame_24_light;

const firstAccordionKey = Key("first_accordion");
const firstAccordionChildKey = Key("first_accordion_child");
const secondAccordionKey = Key("second_accordion");
const secondAccordionChildKey = Key("second_accordion_child");

class SingleAccordionTestWidget extends StatelessWidget {
  final bool isDisabled;

  const SingleAccordionTestWidget({super.key, this.isDisabled = false});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonAccordion<AccordionItems>(
          isDisabled: isDisabled,
          key: firstAccordionKey,
          accordionSize: MoonAccordionSize.md,
          textColor: context.moonColors?.piccolo,
          expandedTextColor: Colors.amber,
          iconColor: Colors.red,
          expandedIconColor: Colors.green,
          borderColor: Colors.blue,
          backgroundColor: Colors.yellow,
          expandedBackgroundColor: Colors.brown,
          childrenPadding: const EdgeInsets.all(12),
          leading: const Icon(accordionIcon),
          label: const Text(accordionTitle),
          children: const [
            Text(
              accordionContent,
              key: firstAccordionChildKey,
            ),
          ],
        ),
      ),
    );
  }
}

class GroupedAccordionTestWidget extends StatefulWidget {
  const GroupedAccordionTestWidget({
    super.key,
  });

  @override
  State<GroupedAccordionTestWidget> createState() => _GroupedAccordionTestWidgetState();
}

class _GroupedAccordionTestWidgetState extends State<GroupedAccordionTestWidget> {
  AccordionItems? _currentlyOpenAccordionItem = AccordionItems.first;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          clipBehavior: Clip.none,
          children: [
            MoonAccordion<AccordionItems>(
              key: firstAccordionKey,
              identityValue: AccordionItems.first,
              groupIdentityValue: _currentlyOpenAccordionItem,
              onExpansionChanged: (AccordionItems? value) {
                setState(() => _currentlyOpenAccordionItem = value);
              },
              leading: const Icon(MoonIcons.other_frame_24_light),
              label: const Text("Grouped MoonAccordion item #1"),
              children: const [
                Text(
                  accordionContent,
                  key: firstAccordionChildKey,
                ),
              ],
            ),
            const SizedBox(height: 8),
            MoonAccordion<AccordionItems>(
              key: secondAccordionKey,
              identityValue: AccordionItems.second,
              groupIdentityValue: _currentlyOpenAccordionItem,
              onExpansionChanged: (AccordionItems? value) {
                setState(() => _currentlyOpenAccordionItem = value);
              },
              leading: const Icon(MoonIcons.other_frame_24_light),
              label: const Text("Grouped MoonAccordion item #2"),
              children: const [
                Text(
                  accordionContent,
                  key: secondAccordionChildKey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
