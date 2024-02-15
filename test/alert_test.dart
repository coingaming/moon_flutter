import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("alert_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: MoonAlert(
          key: key,
          label: Text(alertTitle),
        ),
      ),
    );
    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets("Simple alert", (tester) async {
    await tester.pumpWidget(
      const TestWidget(),
    );

    expect(find.text(alertTitle), findsOneWidget);
  });

  testWidgets("Alert with leading, trailing, body", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        showLeading: true,
        showBody: true,
        showTrailing: true,
      ),
    );
    expect(find.text(alertTitle), findsOneWidget);
    expect(find.text(alertBody), findsOneWidget);
    expect(find.byIcon(trailingIcon), findsOneWidget);
    expect(find.byIcon(leadingIcon), findsOneWidget);
  });

  testWidgets("Hide alert", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        showTrailing: true,
      ),
    );
    final trailing = find.byIcon(trailingIcon);

    expect(find.text(alertTitle), findsOneWidget);
    expect(trailing, findsOneWidget);

    await tester.tap(trailing);
    await tester.pumpAndSettle();
    expect(find.text(alertTitle), findsNothing);
  });
}

const String alertTitle = "Alert title";
const String alertBody = "Alert body";
const IconData leadingIcon = MoonIcons.other_frame_24_light;
const IconData trailingIcon = MoonIcons.controls_close_small_24_light;

class TestWidget extends StatefulWidget {
  final bool showLeading;
  final bool showTrailing;
  final bool showBody;

  const TestWidget({
    super.key,
    this.showLeading = false,
    this.showTrailing = false,
    this.showBody = false,
  });
  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  bool _showAlert = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonAlert(
          show: _showAlert,
          leading: widget.showLeading ? const Icon(leadingIcon) : null,
          label: const SizedBox(
            height: 24,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(alertTitle),
            ),
          ),
          trailing: widget.showTrailing
              ? MoonButton.icon(
                  buttonSize: MoonButtonSize.xs,
                  disabledOpacityValue: 1,
                  icon: const Icon(trailingIcon, size: 24),
                  gap: 0,
                  onTap: () => setState(() => _showAlert = !_showAlert),
                )
              : null,
          content: widget.showBody
              ? const SizedBox(
                  height: 24,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(alertBody),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
