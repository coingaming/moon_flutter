import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("switch_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MoonSwitch && widget.key == key,
      ),
      findsOneWidget,
    );
  });

  testWidgets("Toggle switch", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MoonSwitch && widget.value == true,
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MoonSwitch && widget.value == false,
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is MoonSwitch && widget.value == true,
      ),
      findsOneWidget,
    );
  });
}

class TestWidget extends StatefulWidget {
  final Key? widgetKey;

  const TestWidget({super.key, this.widgetKey});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  var _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonSwitch(
          key: widget.widgetKey,
          value: _switchValue,
          onChanged: (bool newValue) => setState(() => _switchValue = newValue),
        ),
      ),
    );
  }
}
