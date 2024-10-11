import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _tabBarKey = Key("tab_bar_test");

const String _firstTabLabel = "Label 1";
const String _secondTabLabel = "Label 2";
const String _thirdTabLabel = "Label 3";
const String _fourthTabLabel = "Label 4";
const IconData _tabLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _tabTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _TabBarTestWidget(
        tabBarKey: _tabBarKey,
      ),
    );

    expect(find.byKey(_tabBarKey), findsOneWidget);
  });

  testWidgets("Tab bar has a leading, label and trailing widget.",
      (tester) async {
    await tester.pumpWidget(
      const _TabBarTestWidget(
        showLabel: true,
        showLeading: true,
        showTrailing: true,
      ),
    );

    expect(find.textContaining(_firstTabLabel), findsWidgets);
    expect(find.textContaining(_secondTabLabel), findsWidgets);
    expect(find.textContaining(_thirdTabLabel), findsWidgets);
    expect(find.textContaining(_fourthTabLabel), findsWidgets);
    expect(find.byIcon(_tabLeadingIcon), findsWidgets);
    expect(find.byIcon(_tabTrailingIcon), findsWidgets);
  });

  testWidgets("Tab onTap callback works.", (tester) async {
    var value = 0;

    await tester.pumpWidget(
      _TabBarTestWidget(
        showLabel: true,
        onTap: (index) => value = index,
      ),
    );

    await tester.tap(find.text(_secondTabLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 1);

    await tester.tap(find.text(_firstTabLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 0);

    await tester.tap(find.text(_thirdTabLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 2);
  });

  testWidgets("OnTap callback of a disabled tab is ignored.", (tester) async {
    var value = 0;

    await tester.pumpWidget(
      _TabBarTestWidget(
        showLabel: true,
        isDisabled: true,
        onTap: (index) => value = index,
      ),
    );

    await tester.tap(find.text(_secondTabLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 0);

    await tester.tap(find.text(_firstTabLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 0);

    await tester.tap(find.text(_thirdTabLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 0);
  });
}

class _TabBarTestWidget extends StatelessWidget {
  final Key? tabBarKey;
  final bool showLeading;
  final bool showLabel;
  final bool showTrailing;
  final bool isDisabled;
  final void Function(int)? onTap;

  const _TabBarTestWidget({
    this.tabBarKey,
    this.showLeading = false,
    this.showLabel = false,
    this.showTrailing = false,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonTabBar(
          key: tabBarKey,
          onTabChanged: onTap,
          tabs: [
            MoonTab(
              disabled: isDisabled,
              leading: showLeading ? const Icon(_tabLeadingIcon) : null,
              label: showLabel ? const Text(_firstTabLabel) : null,
              trailing: showTrailing ? const Icon(_tabTrailingIcon) : null,
            ),
            MoonTab(
              disabled: isDisabled,
              leading: showLeading ? const Icon(_tabLeadingIcon) : null,
              label: showLabel ? const Text(_secondTabLabel) : null,
              trailing: showTrailing ? const Icon(_tabTrailingIcon) : null,
            ),
            MoonTab(
              disabled: isDisabled,
              leading: showLeading ? const Icon(_tabLeadingIcon) : null,
              label: showLabel ? const Text(_thirdTabLabel) : null,
              trailing: showTrailing ? const Icon(_tabTrailingIcon) : null,
            ),
            MoonTab(
              disabled: isDisabled,
              leading: showLeading ? const Icon(_tabLeadingIcon) : null,
              label: showLabel ? const Text(_fourthTabLabel) : null,
              trailing: showTrailing ? const Icon(_tabTrailingIcon) : null,
            ),
          ],
        ),
      ),
    );
  }
}
