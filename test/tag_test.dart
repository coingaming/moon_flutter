import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _tagKey = Key("tagKey");

const String _tagLabel = "Label";
const IconData _tagLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _tagTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _TagTestWidget(
        tagKey: _tagKey,
      ),
    );

    expect(find.byKey(_tagKey), findsOneWidget);
  });

  testWidgets("Default tag has no leading, label or trailing widget.", (tester) async {
    await tester.pumpWidget(const _TagTestWidget());

    expect(find.text(_tagLabel), findsNothing);
    expect(find.text(_tagLabel), findsNothing);
    expect(find.text(_tagLabel), findsNothing);
  });

  testWidgets("Tag has a leading, label and trailing widget.", (tester) async {
    await tester.pumpWidget(
      const _TagTestWidget(
        showLeading: true,
        showLabel: true,
        showTrailing: true,
      ),
    );

    expect(find.text(_tagLabel), findsOneWidget);
    expect(find.byIcon(_tagTrailingIcon), findsOneWidget);
    expect(find.byIcon(_tagLeadingIcon), findsOneWidget);
  });

  testWidgets("Tag onTap callback works.", (tester) async {
    bool isTapped = false;

    await tester.pumpWidget(
      _TagTestWidget(
        tagKey: _tagKey,
        showTrailing: true,
        onTap: () => isTapped = true,
      ),
    );

    await tester.tap(find.byKey(_tagKey));
    await tester.pumpAndSettle();

    expect(isTapped, true);
  });

  testWidgets("Tag onLongPress callback works.", (tester) async {
    bool longPressed = false;
    bool tapped = false;

    await tester.pumpWidget(
      _TagTestWidget(
        tagKey: _tagKey,
        onLongPress: () => longPressed = true,
        onTap: () => tapped = true,
      ),
    );

    await tester.longPress(find.byKey(_tagKey));
    await tester.pumpAndSettle();

    expect(longPressed, true);
    expect(tapped, false);
  });
}

class _TagTestWidget extends StatelessWidget {
  final Key? tagKey;
  final bool showLeading;
  final bool showLabel;
  final bool showTrailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const _TagTestWidget({
    this.tagKey,
    this.showLeading = false,
    this.showLabel = false,
    this.showTrailing = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonTag(
          key: tagKey,
          onTap: onTap,
          onLongPress: onLongPress,
          leading: showLeading ? const Icon(_tagLeadingIcon) : null,
          label: showLabel ? const Text(_tagLabel) : null,
          trailing: showTrailing ? const Icon(_tagTrailingIcon) : null,
        ),
      ),
    );
  }
}
