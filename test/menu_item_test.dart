import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("menu_item_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );
    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets("Simple menu item", (tester) async {
    await tester.pumpWidget(
      const TestWidget(),
    );

    expect(find.text(title), findsOneWidget);
  });

  testWidgets("Menu item with leading, trailing, description", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        showLeading: true,
        showDiscription: true,
        showTrailing: true,
      ),
    );
    expect(find.text(description), findsOneWidget);
    expect(find.byIcon(trailingIcon), findsOneWidget);
    expect(find.byIcon(leadinIcon), findsOneWidget);
  });

  testWidgets("Tap menu item", (tester) async {
    bool value = false;
    await tester.pumpWidget(
      TestWidget(
        onTap: () => value = !value,
      ),
    );
    await tester.tap(find.byType(MoonMenuItem));
    await tester.pumpAndSettle();
    expect(value, true);
  });
}

const String title = "Title";
const String description = "Description";
const IconData leadinIcon = MoonIcons.other_frame_24_light;
const IconData trailingIcon = MoonIcons.controls_close_small_24_light;

class TestWidget extends StatelessWidget {
  final bool showLeading;
  final bool showTrailing;
  final bool showDiscription;
  final Key? widgetKey;
  final VoidCallback? onTap;

  const TestWidget({
    super.key,
    this.showLeading = false,
    this.showDiscription = false,
    this.showTrailing = false,
    this.widgetKey,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonMenuItem(
          key: widgetKey,
          leading: showLeading ? const Icon(leadinIcon) : null,
          description: showDiscription ? const Text(description) : null,
          title: const Text(title),
          trailing: showTrailing ? const Icon(trailingIcon) : null,
          onTap: onTap,
        ),
      ),
    );
  }
}
