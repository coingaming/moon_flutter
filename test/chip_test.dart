import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _chipKey = Key("chipKey");

const String _chipLabel = "Label";
const IconData _chipLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _chipTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _ChipTestWidget(
        chipKey: _chipKey,
      ),
    );

    expect(find.byKey(_chipKey), findsOneWidget);
  });

  testWidgets("Chip has only a label and no leading or trailing widget.", (tester) async {
    await tester.pumpWidget(
      const _ChipTestWidget(
        showLabel: true,
      ),
    );

    expect(find.text(_chipLabel), findsOneWidget);
    expect(find.byIcon(_chipTrailingIcon), findsNothing);
    expect(find.byIcon(_chipLeadingIcon), findsNothing);
  });

  testWidgets("Chip has a leading, label and trailing widget.", (tester) async {
    await tester.pumpWidget(
      const _ChipTestWidget(
        showLeading: true,
        showLabel: true,
        showTrailing: true,
      ),
    );

    expect(find.byIcon(_chipLeadingIcon), findsOneWidget);
    expect(find.text(_chipLabel), findsOneWidget);
    expect(find.byIcon(_chipTrailingIcon), findsOneWidget);
  });
}

class _ChipTestWidget extends StatelessWidget {
  final Key? chipKey;
  final bool showLeading;
  final bool showTrailing;
  final bool showLabel;

  const _ChipTestWidget({
    this.chipKey,
    this.showLeading = false,
    this.showLabel = false,
    this.showTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonChip(
          key: chipKey,
          leading: showLeading ? const Icon(_chipLeadingIcon) : null,
          label: showLabel ? const Text(_chipLabel) : null,
          trailing: showTrailing ? const Icon(_chipTrailingIcon) : null,
        ),
      ),
    );
  }
}
