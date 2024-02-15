import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("chip_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        widgetKey: key,
      ),
    );
    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets("Simple chip", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        showLabel: true,
      ),
    );

    expect(find.text(label), findsOneWidget);
  });

  testWidgets("Chip with leading, trailing, body", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        showLeading: true,
        showLabel: true,
        showTrailing: true,
      ),
    );
    expect(find.text(label), findsOneWidget);
    expect(find.byIcon(trailingIcon), findsOneWidget);
    expect(find.byIcon(leadingIcon), findsOneWidget);
  });
}

const String label = "Label";
const IconData leadingIcon = MoonIcons.other_frame_24_regular;
const IconData trailingIcon = MoonIcons.controls_close_small_24_regular;

class TestWidget extends StatelessWidget {
  final bool showLeading;
  final bool showTrailing;
  final bool showLabel;
  final Key? widgetKey;

  const TestWidget({
    super.key,
    this.showLeading = false,
    this.showLabel = false,
    this.showTrailing = false,
    this.widgetKey,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonChip(
          key: widgetKey,
          leading: showLeading ? const Icon(leadingIcon) : null,
          label: showLabel ? const Text(label) : null,
          trailing: showTrailing ? const Icon(trailingIcon) : null,
        ),
      ),
    );
  }
}
