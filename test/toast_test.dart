import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  testWidgets("Open toast", (tester) async {
    await tester.pumpWidget(
      TestWidget(),
    );
    await tester.tap(find.byType(MoonFilledButton));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(title), findsOneWidget);
    expect(find.text(body), findsOneWidget);
    expect(find.byIcon(leadingIcon), findsOneWidget);
    expect(find.byIcon(trailingIcon), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(title), findsNothing);
  });
}

const IconData leadingIcon = MoonIcons.other_frame_24_regular;
const IconData trailingIcon = MoonIcons.controls_close_small_24_regular;
const title = 'Title';
const body = 'Body';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return MoonFilledButton(
              label: const Text("Tap me"),
              onTap: () {
                MoonToast.show(
                  context,
                  displayDuration: const Duration(milliseconds: 500),
                  transitionDuration: Duration.zero,
                  leading: const Icon(leadingIcon),
                  label: const Text(title),
                  trailing: const Icon(trailingIcon),
                  content: const Text(body),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
