import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("auth_code_test");

  testWidgets("Provided key is used", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        authCodeKey: key,
      ),
    );
    expect(find.byKey(key), findsOneWidget);
  });

  testWidgets("Enter valid code", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        authCodeKey: key,
      ),
    );
    final widget = find.byType(TextFormField).first;
    await tester.enterText(widget, '9921');
    await tester.pump(const Duration(milliseconds: 110));
    expect(find.text(errorMessage), findsNothing);
  });
  testWidgets("Enter invalid code", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        authCodeKey: key,
      ),
    );
    final widget = find.byType(TextFormField).first;
    await tester.enterText(widget, '1111');
    await tester.pump(const Duration(milliseconds: 110));
    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets("Initial error message", (tester) async {
    await tester.pumpWidget(
      const TestWidget(
        authCodeKey: key,
        initialErrorMessage: initialErrorMessage,
      ),
    );
    final widget = find.byType(TextFormField).first;
    expect(find.text(initialErrorMessage), findsOneWidget);
    await tester.enterText(widget, '1111');
    await tester.pump(const Duration(milliseconds: 110));
    expect(find.text(initialErrorMessage), findsNothing);
    expect(find.text(errorMessage), findsOneWidget);
  });
}

const errorMessage = 'Invalid authentication code. Please try again.';
const initialErrorMessage = 'Initial error message';

class TestWidget extends StatelessWidget {
  const TestWidget({
    super.key,
    this.authCodeKey,
    this.initialErrorMessage,
  });

  final Key? authCodeKey;
  final String? initialErrorMessage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: MoonAuthCode(
            key: authCodeKey,
            authInputFieldCount: 4,
            autoFocus: true,
            enableInputFill: true,
            validator: (String? pin) {
              return pin?.length == 4 && pin != '9921' ? errorMessage : null;
            },
            errorText: initialErrorMessage,
            errorBuilder: (BuildContext context, String? errorText) {
              return Align(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(errorText ?? ''),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
