import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _buttonKey = Key("buttonKey");

const String _buttonLabel = "Label";
const IconData _buttonLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _buttonTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _ButtonTestWidget(
        buttonKey: _buttonKey,
      ),
    );

    expect(find.byKey(_buttonKey), findsOneWidget);
  });

  testWidgets("Button has a leading, label and trailing widget.", (tester) async {
    await tester.pumpWidget(
      const _ButtonTestWidget(
        showLeading: true,
        showLabel: true,
        showTrailing: true,
      ),
    );

    expect(find.text(_buttonLabel), findsOneWidget);
    expect(find.byIcon(_buttonTrailingIcon), findsOneWidget);
    expect(find.byIcon(_buttonLeadingIcon), findsOneWidget);
  });

  testWidgets("Button onTap callback works.", (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      _ButtonTestWidget(
        buttonKey: _buttonKey,
        onTap: () => tapped = true,
      ),
    );

    await tester.tap(find.byKey(_buttonKey));
    await tester.pumpAndSettle();

    expect(tapped, true);
  });

  testWidgets("Button onLongPress callback works.", (tester) async {
    bool longPressed = false;

    await tester.pumpWidget(
      _ButtonTestWidget(
        buttonKey: _buttonKey,
        onLongPress: () => longPressed = true,
      ),
    );

    await tester.longPress(find.byKey(_buttonKey));
    await tester.pumpAndSettle();

    expect(longPressed, true);
  });
}

class _ButtonTestWidget extends StatelessWidget {
  final Key? buttonKey;
  final bool showLeading;
  final bool showTrailing;
  final bool showLabel;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const _ButtonTestWidget({
    this.buttonKey,
    this.showLeading = false,
    this.showTrailing = false,
    this.showLabel = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonButton(
          key: buttonKey,
          onLongPress: onLongPress,
          onTap: onTap,
          leading: showLeading ? const Icon(_buttonLeadingIcon) : null,
          label: showLabel ? const Text(_buttonLabel) : null,
          trailing: showTrailing ? const Icon(_buttonTrailingIcon) : null,
        ),
      ),
    );
  }
}
