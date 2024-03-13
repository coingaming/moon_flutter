import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:moon_design/src/widgets/buttons/filled_button.dart';
import 'package:moon_design/src/widgets/tooltip/tooltip.dart';

const Key _tooltipKey = Key("tooltipKey");
const Key _showButtonKey = Key("_showButtonKey");

const Widget _tooltipContent = Text("Content");

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _ToastTestWidget(
        tooltipKey: _tooltipKey,
      ),
    );

    expect(find.byKey(_tooltipKey), findsOneWidget);
  });

  testWidgets("Tooltip is displayed when the 'show' button is tapped.", (tester) async {
    await tester.pumpWidget(
      const _ToastTestWidget(
        tooltipKey: _tooltipKey,
      ),
    );
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_tooltipContent), findsOneWidget);
  });

  testWidgets("Tooltip closes when tapped.", (tester) async {
    await tester.pumpWidget(
      const _ToastTestWidget(
        tooltipKey: _tooltipKey,
      ),
    );
    final button = find.byKey(_showButtonKey);
    final tooltipContent = find.byWidget(_tooltipContent);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    await tester.tap(tooltipContent);
    await tester.pumpAndSettle();

    expect(tooltipContent, findsNothing);
  });

  testWidgets("Provided background color is used.", (tester) async {
    await tester.pumpWidget(
      const _ToastTestWidget(
        tooltipKey: _tooltipKey,
        color: Colors.blue,
      ),
    );
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_tooltipContent), findsOneWidget);
    expect(
      find.byWidgetPredicate((Widget widget) => widget is MoonTooltip && widget.backgroundColor == Colors.blue),
      findsOneWidget,
    );
  });
}

class _ToastTestWidget extends StatefulWidget {
  final Key? tooltipKey;
  final Color color;

  const _ToastTestWidget({
    this.tooltipKey,
    this.color = Colors.white,
  });

  @override
  State<_ToastTestWidget> createState() => _ToastTestWidgetState();
}

class _ToastTestWidgetState extends State<_ToastTestWidget> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: MoonTooltip(
                key: widget.tooltipKey,
                show: _show,
                backgroundColor: widget.color,
                content: _tooltipContent,
                child: MoonFilledButton(
                  key: _showButtonKey,
                  onTap: () => setState(() => _show = true),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
