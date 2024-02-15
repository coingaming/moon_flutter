import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("button_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        key: key,
      ),
    );
    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets("Button with leading, trailing, label", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        showLeading: true,
        showLabel: true,
        showTrailing: true,
      ),
    );
    expect(find.text(buttonLabel), findsOneWidget);
    expect(find.byIcon(trailingIcon), findsOneWidget);
    expect(find.byIcon(leadingIcon), findsOneWidget);
  });

  testWidgets("Button tap", (tester) async {
    bool tapped = false;
    await tester.pumpWidget(
      TestWidget(
        onTap: () => tapped = true,
      ),
    );
    await tester.tap(find.byType(MoonButton));
    await tester.pumpAndSettle();
    expect(tapped, true);
  });

  testWidgets("Button long press", (tester) async {
    bool longPressed = false;
    bool tapped = false;
    await tester.pumpWidget(
      TestWidget(
        onLongPress: () => longPressed = true,
        onTap: () => tapped = true,
      ),
    );
    await tester.longPress(find.byType(MoonButton));
    await tester.pumpAndSettle();
    expect(longPressed, true);
    expect(tapped, false);
  });
}

const String buttonLabel = "Button label";
const IconData leadingIcon = MoonIcons.other_frame_24_regular;
const IconData trailingIcon = MoonIcons.controls_close_small_24_regular;

class TestWidget extends StatefulWidget {
  final bool showLeading;
  final bool showTrailing;
  final bool showLabel;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Key? buttonKey;

  const TestWidget({
    super.key,
    this.showLeading = false,
    this.showTrailing = false,
    this.showLabel = false,
    this.buttonKey,
    this.onTap,
    this.onLongPress,
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
        body: MoonButton(
          key: widget.buttonKey,
          onLongPress: widget.onLongPress,
          onTap: widget.onTap,
          leading: widget.showLeading ? const Icon(leadingIcon) : null,
          label: widget.showLabel
              ? const SizedBox(
                  height: 24,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(buttonLabel),
                  ),
                )
              : null,
          trailing: widget.showTrailing
              ? MoonButton.icon(
                  buttonSize: MoonButtonSize.xs,
                  disabledOpacityValue: 1,
                  icon: const Icon(trailingIcon, size: 24),
                  gap: 0,
                  onTap: () => setState(() => _showAlert = !_showAlert),
                )
              : null,
        ),
      ),
    );
  }
}
