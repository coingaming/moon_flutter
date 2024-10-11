import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _switchKey = Key("switchKey");

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _SwitchTestWidget(
        switchKey: _switchKey,
      ),
    );

    expect(find.byKey(_switchKey), findsOneWidget);
  });

  testWidgets("Tapping on a switch changes its value.", (tester) async {
    await tester.pumpWidget(
      const _SwitchTestWidget(
        switchKey: _switchKey,
      ),
    );

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is MoonSwitch && widget.value == true,
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(_switchKey));
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is MoonSwitch && widget.value == false,
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(_switchKey));
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is MoonSwitch && widget.value == true,
      ),
      findsOneWidget,
    );
  });
}

class _SwitchTestWidget extends StatefulWidget {
  final Key? switchKey;

  const _SwitchTestWidget({this.switchKey});

  @override
  State<_SwitchTestWidget> createState() => _SwitchTestWidgetState();
}

class _SwitchTestWidgetState extends State<_SwitchTestWidget> {
  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonSwitch(
          key: widget.switchKey,
          value: _switchValue,
          onChanged: (bool newValue) => setState(() => _switchValue = newValue),
        ),
      ),
    );
  }
}
