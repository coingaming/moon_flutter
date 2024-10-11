import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _segmentedControlKey = Key("segmentControlKey");

const String _firstSegmentLabel = "Label 1";
const String _secondSegmentLabel = "Label 2";
const String _thirdSegmentLabel = "Label 3";
const IconData _segmentLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _segmentTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _SegmentedControlTestWidget(
        segmentedControlKey: _segmentedControlKey,
      ),
    );

    expect(find.byKey(_segmentedControlKey), findsOneWidget);
  });

  testWidgets("Segment has a leading, label and trailing widget.",
      (tester) async {
    await tester.pumpWidget(
      const _SegmentedControlTestWidget(
        showLabel: true,
        showLeading: true,
        showTrailing: true,
      ),
    );

    expect(find.textContaining(_firstSegmentLabel), findsWidgets);
    expect(find.textContaining(_secondSegmentLabel), findsWidgets);
    expect(find.textContaining(_thirdSegmentLabel), findsWidgets);
    expect(find.byIcon(_segmentLeadingIcon), findsWidgets);
    expect(find.byIcon(_segmentTrailingIcon), findsWidgets);
  });

  testWidgets("Segment onTap callback works.", (tester) async {
    var value = 0;

    await tester.pumpWidget(
      _SegmentedControlTestWidget(
        showLabel: true,
        onTap: (int index) => value = index,
      ),
    );

    await tester.tap(find.text(_secondSegmentLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 1);

    await tester.tap(find.text(_firstSegmentLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 0);

    await tester.tap(find.text(_thirdSegmentLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 2);
  });

  testWidgets(
      "The onTap callbacks of segments are ignored if segmented control is "
      "disabled.", (tester) async {
    var value = 0;

    await tester.pumpWidget(
      _SegmentedControlTestWidget(
        showLabel: true,
        isDisabled: true,
        onTap: (int index) => value = index,
      ),
    );

    await tester.tap(find.text(_secondSegmentLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 0);

    await tester.tap(find.text(_firstSegmentLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 0);

    await tester.tap(find.text(_thirdSegmentLabel), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(value, 0);
  });
}

class _SegmentedControlTestWidget extends StatelessWidget {
  final Key? segmentedControlKey;
  final bool showLeading;
  final bool showLabel;
  final bool showTrailing;
  final bool isDisabled;
  final void Function(int)? onTap;

  const _SegmentedControlTestWidget({
    this.segmentedControlKey,
    this.showLeading = false,
    this.showLabel = false,
    this.showTrailing = false,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonSegmentedControl(
          key: segmentedControlKey,
          isDisabled: isDisabled,
          onSegmentChanged: onTap,
          segments: [
            Segment(
              leading: showLeading ? const Icon(_segmentLeadingIcon) : null,
              label: showLabel ? const Text(_firstSegmentLabel) : null,
              trailing: showTrailing ? const Icon(_segmentTrailingIcon) : null,
            ),
            Segment(
              leading: showLeading ? const Icon(_segmentLeadingIcon) : null,
              label: showLabel ? const Text(_secondSegmentLabel) : null,
              trailing: showTrailing ? const Icon(_segmentTrailingIcon) : null,
            ),
            Segment(
              leading: showLeading ? const Icon(_segmentLeadingIcon) : null,
              label: showLabel ? const Text(_thirdSegmentLabel) : null,
              trailing: showTrailing ? const Icon(_segmentTrailingIcon) : null,
            ),
          ],
        ),
      ),
    );
  }
}
