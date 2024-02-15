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
        showDescription: true,
        showTrailing: true,
      ),
    );
    expect(find.text(description), findsOneWidget);
    expect(find.byIcon(trailingIcon), findsOneWidget);
    expect(find.byIcon(leadingIcon), findsOneWidget);
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
const IconData leadingIcon = MoonIcons.other_frame_24_regular;
const IconData trailingIcon = MoonIcons.controls_close_small_24_regular;

class TestWidget extends StatelessWidget {
  final bool showLeading;
  final bool showTrailing;
  final bool showDescription;
  final Key? widgetKey;
  final VoidCallback? onTap;

  const TestWidget({
    super.key,
    this.showLeading = false,
    this.showDescription = false,
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
          leading: showLeading ? const Icon(leadingIcon) : null,
          content: showDescription ? const Text(description) : null,
          label: const Text(title),
          trailing: showTrailing ? const Icon(trailingIcon) : null,
          onTap: onTap,
        ),
      ),
    );
  }
}
