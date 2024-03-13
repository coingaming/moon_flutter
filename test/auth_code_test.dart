import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _authCodeKey = Key("authCodeKey");

const String _validatorErrorMessage = 'Validator error message.';
const String _providedErrorMessage = 'Provided error message.';

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _AuthCodeTestWidget(
        authCodeKey: _authCodeKey,
      ),
    );

    expect(find.byKey(_authCodeKey), findsOneWidget);
  });

  testWidgets("When valid code is entered, error message is not shown.", (tester) async {
    await tester.pumpWidget(const _AuthCodeTestWidget());
    final widget = find.byType(TextFormField).first;

    await tester.enterText(widget, '9921');
    await tester.pump();

    expect(find.text(_validatorErrorMessage), findsNothing);
  });

  testWidgets("When invalid code is entered, error message is shown.", (tester) async {
    await tester.pumpWidget(const _AuthCodeTestWidget());
    final widget = find.byType(TextFormField).first;

    await tester.enterText(widget, '1111');
    await tester.pump();

    expect(find.text(_validatorErrorMessage), findsOneWidget);
  });

  testWidgets("Validator errors take precedence over the provided errorText.", (tester) async {
    await tester.pumpWidget(
      const _AuthCodeTestWidget(
        providedErrorMessage: _providedErrorMessage,
      ),
    );
    final widget = find.byType(TextFormField).first;

    expect(find.text(_providedErrorMessage), findsOneWidget);

    await tester.enterText(widget, '1111');
    await tester.pump();

    expect(find.text(_providedErrorMessage), findsNothing);
    expect(find.text(_validatorErrorMessage), findsOneWidget);
  });
}

class _AuthCodeTestWidget extends StatelessWidget {
  final Key? authCodeKey;
  final String? providedErrorMessage;

  const _AuthCodeTestWidget({this.authCodeKey, this.providedErrorMessage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: MoonAuthCode(
            key: authCodeKey,
            authInputFieldCount: 4,
            errorText: providedErrorMessage,
            validator: (String? pin) => pin?.length == 4 && pin != '9921' ? _validatorErrorMessage : null,
            errorBuilder: (BuildContext context, String? errorText) => Text(errorText ?? ''),
          ),
        ),
      ),
    );
  }
}
