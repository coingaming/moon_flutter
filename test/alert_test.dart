import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _alertKey = Key("alertKey");
const Key _closeButtonKey = Key("closeButtonKey");

const String _alertLabel = "Label";
const String _alertBody = "Body";
const IconData _alertLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _alertTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _AlertTestWidget(
        alertKey: _alertKey,
      ),
    );

    expect(find.byKey(_alertKey), findsOneWidget);
  });

  testWidgets("Alert has only label widget and no leading, trailing or body widget.", (tester) async {
    await tester.pumpWidget(const _AlertTestWidget());

    expect(find.text(_alertLabel), findsOneWidget);
    expect(find.text(_alertBody), findsNothing);
    expect(find.byIcon(_alertTrailingIcon), findsNothing);
    expect(find.byIcon(_alertLeadingIcon), findsNothing);
  });

  testWidgets("Alert has a leading, trailing and body widget.", (tester) async {
    await tester.pumpWidget(
      const _AlertTestWidget(
        showLeading: true,
        showBody: true,
        showTrailing: true,
      ),
    );

    expect(find.text(_alertLabel), findsOneWidget);
    expect(find.text(_alertBody), findsOneWidget);
    expect(find.byIcon(_alertTrailingIcon), findsOneWidget);
    expect(find.byIcon(_alertLeadingIcon), findsOneWidget);
  });

  testWidgets("Alert is not visible when the 'close' button is tapped.", (tester) async {
    await tester.pumpWidget(
      const _AlertTestWidget(
        showTrailing: true,
      ),
    );
    final trailing = find.byKey(_closeButtonKey);

    expect(find.text(_alertLabel), findsOneWidget);
    expect(trailing, findsOneWidget);

    await tester.tap(trailing, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.text(_alertLabel), findsNothing);
  });
}

class _AlertTestWidget extends StatefulWidget {
  final Key? alertKey;
  final bool showLeading;
  final bool showTrailing;
  final bool showBody;

  const _AlertTestWidget({
    this.alertKey,
    this.showLeading = false,
    this.showTrailing = false,
    this.showBody = false,
  });

  @override
  State<_AlertTestWidget> createState() => _AlertTestWidgetState();
}

class _AlertTestWidgetState extends State<_AlertTestWidget> {
  bool _showAlert = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonAlert(
          key: widget.alertKey,
          show: _showAlert,
          leading: widget.showLeading ? const Icon(_alertLeadingIcon) : null,
          label: const Text(_alertLabel),
          trailing: widget.showTrailing
              ? MoonButton.icon(
                  key: _closeButtonKey,
                  icon: const Icon(_alertTrailingIcon),
                  onTap: () => setState(() => _showAlert = !_showAlert),
                )
              : null,
          content: widget.showBody ? const Text(_alertBody) : null,
        ),
      ),
    );
  }
}
