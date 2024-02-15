import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("breadcrumb_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MoonBreadcrumb && widget.key == key,
      ),
      findsOneWidget,
    );
  });

  testWidgets("More items button", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );
    final moreButton = find.text('...');

    expect(moreButton, findsOneWidget);
    expect(find.textContaining('1'), findsNothing);

    await tester.tap(moreButton);
    await tester.pumpAndSettle();
    expect(find.textContaining('1'), findsOneWidget);
  });

  testWidgets("Item with leading, custom divider and label", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        showLeading: true,
      ),
    );

    expect(find.textContaining('p'), findsWidgets);

    expect(find.byIcon(leadingIcon), findsWidgets);
    expect(find.byIcon(dividerIcon), findsWidgets);
  });

  testWidgets("Test max itemsToShow", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
        itemsToShow: 2,
      ),
    );
    final moreButton = find.text('...');

    expect(moreButton, findsOneWidget);
    expect(find.textContaining('p'), findsNWidgets(2));

    await tester.tap(moreButton);
    await tester.pumpAndSettle();
    expect(find.textContaining('p'), findsNWidgets(4));
  });

  testWidgets("Press breadcrumb item", (tester) async {
    var value = 0;
    await tester.pumpWidget(
      TestWidget(
        widgetKey: key,
        onPressed: (index) => value = index,
      ),
    );

    await tester.tap(find.textContaining('2'));
    await tester.pumpAndSettle();

    expect(value, 2);

    await tester.tap(find.textContaining('0'));
    await tester.pumpAndSettle();

    expect(value, 0);

    final moreButton = find.text('...');

    expect(moreButton, findsOneWidget);
    await tester.tap(moreButton);
    await tester.pumpAndSettle();

    await tester.tap(find.textContaining('1'));
    await tester.pumpAndSettle();

    expect(value, 1);
  });
}

const IconData leadingIcon = MoonIcons.other_frame_24_light;
const IconData dividerIcon = MoonIcons.arrows_chevron_right_double_16_light;

class TestWidget extends StatelessWidget {
  final bool showLeading;
  final int? itemsToShow;
  final void Function(int)? onPressed;
  final Key? widgetKey;

  const TestWidget({
    super.key,
    this.showLeading = false,
    this.itemsToShow,
    this.onPressed,
    this.widgetKey,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: MoonBreadcrumb(
            key: widgetKey,
            visibleItemCount: itemsToShow ?? 3,
            divider: const Icon(dividerIcon),
            items: [
              ...List.generate(4, (i) => i).map(
                (index) {
                  return MoonBreadcrumbItem(
                    label: Text('p$index'),
                    leading: showLeading ? const Icon(leadingIcon) : null,
                    onTap: () => onPressed?.call(index),
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
