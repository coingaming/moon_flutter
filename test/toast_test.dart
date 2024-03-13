import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _showButtonKey = Key('showButtonKey');

const String _toastLabel = 'Label';
const String _toastBody = 'Body';
const IconData _toastLeadingIcon = MoonIcons.other_frame_24_light;
const IconData _toastTrailingIcon = MoonIcons.controls_close_small_24_light;

void main() {
  testWidgets("Toast is displayed when the 'show' button is tapped and dismissed after 2 seconds.", (tester) async {
    await tester.pumpWidget(_ToastTestWidget());
    await tester.tap(find.byKey(_showButtonKey));
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text(_toastLabel), findsOneWidget);
    expect(find.text(_toastBody), findsOneWidget);
    expect(find.byIcon(_toastLeadingIcon), findsOneWidget);
    expect(find.byIcon(_toastTrailingIcon), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));

    expect(find.text(_toastLabel), findsNothing);
  });
}

class _ToastTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            return MoonFilledButton(
              key: _showButtonKey,
              onTap: () {
                MoonToast.show(
                  context,
                  displayDuration: const Duration(seconds: 2),
                  transitionDuration: Duration.zero,
                  leading: const Icon(_toastLeadingIcon),
                  label: const Text(_toastLabel),
                  trailing: const Icon(_toastTrailingIcon),
                  content: const Text(_toastBody),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
