import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _breadcrumbKey = Key("breadcrumbKey");

const String _showMoreButtonText = '...';
const String _breadcrumbItem = 'breadcrumb item';
const IconData _breadcrumbLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _breadcrumbDividerIcon =
    MoonIcons.arrows_chevron_right_double_16_light;

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _BreadCrumbTestWidget(
        breadcrumbKey: _breadcrumbKey,
      ),
    );

    expect(find.byKey(_breadcrumbKey), findsOneWidget);
  });

  testWidgets(
      "Tapping on a 'show more' button expands collapsed items, and the "
      "button itself becomes hidden.", (tester) async {
    await tester.pumpWidget(const _BreadCrumbTestWidget());
    final moreButton = find.text(_showMoreButtonText);

    expect(moreButton, findsOneWidget);
    // Collapsed item with index 1 is not visible.
    expect(find.textContaining('1'), findsNothing);

    await tester.tap(moreButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Collapsed item with index 1 is visible.
    expect(find.textContaining('1'), findsOneWidget);
    expect(find.textContaining(_showMoreButtonText), findsNothing);
  });

  testWidgets("Breadcrumb item has a leading, divider and label widget.",
      (tester) async {
    await tester.pumpWidget(
      const _BreadCrumbTestWidget(
        showLeading: true,
      ),
    );

    expect(find.textContaining(_breadcrumbItem), findsWidgets);
    expect(find.byIcon(_breadcrumbLeadingIcon), findsWidgets);
    expect(find.byIcon(_breadcrumbDividerIcon), findsWidgets);
  });

  testWidgets(
      "Only N items are shown, where N is defined by the value of itemsToShow.",
      (tester) async {
    await tester.pumpWidget(
      const _BreadCrumbTestWidget(
        itemsToShow: 3,
      ),
    );
    final moreButton = find.textContaining(_showMoreButtonText);

    expect(moreButton, findsOneWidget);
    expect(find.textContaining(_breadcrumbItem), findsNWidgets(3));

    await tester.tap(moreButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.textContaining(_breadcrumbItem), findsNWidgets(4));
  });

  testWidgets("Breadcrumb item callback works.", (tester) async {
    int value = 0;

    await tester.pumpWidget(
      _BreadCrumbTestWidget(
        onTap: (index) => value = index,
      ),
    );
    final moreButton = find.text(_showMoreButtonText);

    // Find breadcrumb item with index 2 and tap on it.
    await tester.tap(find.textContaining('2'), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 2);

    // Find breadcrumb item with index 0 and tap on it.
    await tester.tap(find.textContaining('0'), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 0);
    expect(moreButton, findsOneWidget);

    await tester.tap(moreButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    // Find initially collapsed breadcrumb item with index 1 and tap on it.
    await tester.tap(find.textContaining('1'), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 1);
    // Tapping on a 'show more' button expands collapsed items, and the button
    // itself becomes hidden.
    expect(moreButton, findsNothing);
  });
}

class _BreadCrumbTestWidget extends StatelessWidget {
  final Key? breadcrumbKey;
  final bool showLeading;
  final int? itemsToShow;
  final void Function(int)? onTap;

  const _BreadCrumbTestWidget({
    this.breadcrumbKey,
    this.showLeading = false,
    this.itemsToShow,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: MoonBreadcrumb(
            key: breadcrumbKey,
            visibleItemCount: itemsToShow ?? 3,
            divider: const Icon(_breadcrumbDividerIcon),
            items: [
              ...List.generate(4, (i) => i).map(
                (int index) {
                  return MoonBreadcrumbItem(
                    label: Text('$_breadcrumbItem $index'),
                    leading:
                        showLeading ? const Icon(_breadcrumbLeadingIcon) : null,
                    onTap: () => onTap?.call(index),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
