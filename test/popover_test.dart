import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _popoverKey = Key("popoverKey");
const Key _showButtonKey = Key("showButtonKey");
const Key _closeButtonKey = Key("closeButtonKey");

const Widget _content = Text("Content");

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _PopoverTestWidget(
        popoverKey: _popoverKey,
      ),
    );

    expect(find.byKey(_popoverKey), findsOneWidget);
  });

  testWidgets("Popover is displayed when the 'show' button is tapped.", (tester) async {
    await tester.pumpWidget(const _PopoverTestWidget());
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_content), findsOneWidget);
  });

  testWidgets("Popover closes when a tap occurs outside its content, if dismissible.", (tester) async {
    await tester.pumpWidget(const _PopoverTestWidget());
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_content), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(_content), findsNothing);
  });

  testWidgets("Popover stays visible when a tap occurs outside its content, if not dismissible.", (tester) async {
    await tester.pumpWidget(
      const _PopoverTestWidget(
        isDismissible: false,
      ),
    );
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_content), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(_content), findsOneWidget);
  });

  testWidgets("Popover closes when the 'close' button is tapped.", (tester) async {
    await tester.pumpWidget(const _PopoverTestWidget());
    final button = find.byKey(_showButtonKey);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_content), findsOneWidget);

    await tester.tap(find.byKey(_closeButtonKey));
    await tester.pumpAndSettle();

    expect(find.byWidget(_content), findsNothing);
  });
}

class _PopoverTestWidget extends StatefulWidget {
  final Key? popoverKey;
  final bool isDismissible;

  const _PopoverTestWidget({
    this.popoverKey,
    this.isDismissible = true,
  });

  @override
  State<_PopoverTestWidget> createState() => _PopoverTestWidgetState();
}

class _PopoverTestWidgetState extends State<_PopoverTestWidget> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MoonPopover(
            key: widget.popoverKey,
            show: _show,
            onTapOutside: () => setState(() => _show = !widget.isDismissible),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 190),
              child: Column(
                children: [
                  _content,
                  MoonFilledButton(
                    key: _closeButtonKey,
                    onTap: () => setState(() => _show = false),
                  ),
                ],
              ),
            ),
            child: MoonFilledButton(
              key: _showButtonKey,
              onTap: () => setState(() => _show = !_show),
            ),
          ),
        ),
      ),
    );
  }
}
