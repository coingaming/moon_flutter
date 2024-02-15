import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("tag_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: MoonTag(
          key: key,
          label: Text(title),
        ),
      ),
    );
    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets("Simple tag", (tester) async {
    await tester.pumpWidget(
      const TestWidget(),
    );

    expect(find.text(title), findsOneWidget);
  });

  testWidgets("Tag with leading, trailing", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        showLeading: true,
        showTrailing: true,
      ),
    );
    expect(find.text(title), findsOneWidget);
    expect(find.byIcon(trailingIcon), findsOneWidget);
    expect(find.byIcon(leadingIcon), findsOneWidget);
  });

  testWidgets("Press tag", (tester) async {
    bool isPressed = false;
    await tester.pumpWidget(
      TestWidget(
        showTrailing: true,
        onTap: () {
          isPressed = true;
        },
      ),
    );

    await tester.tap(find.byType(MoonTag));
    await tester.pumpAndSettle();
    expect(isPressed, true);
  });
}

const String title = "Tag title";
const IconData leadingIcon = MoonIcons.other_frame_24_regular;
const IconData trailingIcon = MoonIcons.controls_close_small_24_regular;

class TestWidget extends StatelessWidget {
  final bool showLeading;
  final bool showTrailing;

  final VoidCallback? onTap;

  const TestWidget({
    super.key,
    this.showLeading = false,
    this.showTrailing = false,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MoonTag(
          onTap: onTap,
          leading: showLeading ? const Icon(leadingIcon) : null,
          label: const Text(title),
          trailing: showTrailing ? const Icon(trailingIcon) : null,
        ),
      ),
    );
  }
}
