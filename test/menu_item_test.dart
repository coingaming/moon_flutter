import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _menuItemKey = Key("menuItemKey");

const String _menuItemLabel = "Label";
const String _menuItemContent = "Content";
const IconData _menuItemLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _menuItemTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _MenuItemTestWidget(
        menuItemKey: _menuItemKey,
      ),
    );

    expect(find.byKey(_menuItemKey), findsOneWidget);
  });

  testWidgets(
      "Menu item has only label and no leading, trailing or content widget.",
      (tester) async {
    await tester.pumpWidget(const _MenuItemTestWidget());

    expect(find.text(_menuItemLabel), findsOneWidget);
    expect(find.byIcon(_menuItemLeadingIcon), findsNothing);
    expect(find.byIcon(_menuItemTrailingIcon), findsNothing);
    expect(find.text(_menuItemContent), findsNothing);
  });

  testWidgets("Menu item has a leading, label, trailing and content widget.",
      (tester) async {
    await tester.pumpWidget(
      const _MenuItemTestWidget(
        showLeading: true,
        showTrailing: true,
        showContent: true,
      ),
    );

    expect(find.text(_menuItemLabel), findsOneWidget);
    expect(find.byIcon(_menuItemLeadingIcon), findsOneWidget);
    expect(find.byIcon(_menuItemTrailingIcon), findsOneWidget);
    expect(find.text(_menuItemContent), findsOneWidget);
  });

  testWidgets("Menu item onTap callback works.", (tester) async {
    bool value = false;

    await tester.pumpWidget(
      _MenuItemTestWidget(
        menuItemKey: _menuItemKey,
        onTap: () => value = !value,
      ),
    );

    await tester.tap(find.byKey(_menuItemKey));
    await tester.pumpAndSettle();

    expect(value, true);
  });
}

class _MenuItemTestWidget extends StatelessWidget {
  final Key? menuItemKey;
  final bool showLeading;
  final bool showTrailing;
  final bool showContent;
  final VoidCallback? onTap;

  const _MenuItemTestWidget({
    this.menuItemKey,
    this.showLeading = false,
    this.showTrailing = false,
    this.showContent = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonMenuItem(
          key: menuItemKey,
          onTap: onTap,
          leading: showLeading ? const Icon(_menuItemLeadingIcon) : null,
          label: const Text(_menuItemLabel),
          trailing: showTrailing ? const Icon(_menuItemTrailingIcon) : null,
          content: showContent ? const Text(_menuItemContent) : null,
        ),
      ),
    );
  }
}
