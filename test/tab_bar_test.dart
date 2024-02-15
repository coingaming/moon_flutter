import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("tab_bar_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MoonTabBar && widget.key == key,
      ),
      findsOneWidget,
    );
  });

  testWidgets("Tab bar with leading, trailing, label", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        showLabel: true,
        showLeading: true,
        showTrailing: true,
      ),
    );

    expect(find.textContaining(label), findsWidgets);
    expect(find.byIcon(leadingIcon), findsWidgets);
    expect(find.byIcon(trailingIcon), findsWidgets);
  });

  testWidgets("Press tab", (tester) async {
    var value = 0;
    await tester.pumpWidget(
      TestWidget(
        widgetKey: key,
        showLabel: true,
        onTap: (index) => value = index,
      ),
    );

    await tester.tap(find.text('$label 2'));
    await tester.pumpAndSettle();

    expect(value, 1);

    await tester.tap(find.text('$label 1'));
    await tester.pumpAndSettle();

    expect(value, 0);

    await tester.tap(find.text('$label 3'));
    await tester.pumpAndSettle();

    expect(value, 2);
  });

  testWidgets("Disabled press tab", (tester) async {
    var value = 0;
    await tester.pumpWidget(
      TestWidget(
        widgetKey: key,
        showLabel: true,
        isDisabled: true,
        onTap: (index) => value = index,
      ),
    );

    await tester.tap(find.text('$label 2'));
    await tester.pumpAndSettle();

    expect(value, 0);

    await tester.tap(find.text('$label 1'));
    await tester.pumpAndSettle();

    expect(value, 0);

    await tester.tap(find.text('$label 3'));
    await tester.pumpAndSettle();

    expect(value, 0);
  });
}

const String label = "Label";
const IconData leadingIcon = MoonIcons.other_frame_24_regular;
const IconData trailingIcon = MoonIcons.controls_close_small_24_regular;

class TestWidget extends StatelessWidget {
  final bool showLeading;
  final bool showTrailing;
  final bool showLabel;
  final Key? widgetKey;
  final void Function(int)? onTap;
  final bool isDisabled;

  const TestWidget({
    super.key,
    this.showLeading = false,
    this.showLabel = false,
    this.showTrailing = false,
    this.widgetKey,
    this.onTap,
    this.isDisabled = false,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonTabBar(
          key: widgetKey,
          onTabChanged: onTap,
          tabs: [
            MoonTab(
              leading: showLeading ? const Icon(leadingIcon) : null,
              label: showLabel ? const Text('$label 1') : null,
              trailing: showTrailing ? const Icon(trailingIcon) : null,
              disabled: isDisabled,
            ),
            MoonTab(
              leading: showLeading ? const Icon(leadingIcon) : null,
              label: showLabel ? const Text('$label 2') : null,
              trailing: showTrailing ? const Icon(trailingIcon) : null,
              disabled: isDisabled,
            ),
            MoonTab(
              leading: showLeading ? const Icon(leadingIcon) : null,
              label: showLabel ? const Text('$label 3') : null,
              trailing: showTrailing ? const Icon(trailingIcon) : null,
              disabled: isDisabled,
            ),
            MoonTab(
              leading: showLeading ? const Icon(leadingIcon) : null,
              label: showLabel ? const Text('$label 4') : null,
              trailing: showTrailing ? const Icon(trailingIcon) : null,
              disabled: isDisabled,
            ),
          ],
        ),
      ),
    );
  }
}
