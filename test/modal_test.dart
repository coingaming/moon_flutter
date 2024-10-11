import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _modalKey = Key("modalKey");
const Key _showButtonKey = Key("showButtonKey");
const Key _closeButtonKey = Key("closeButtonKey");

const Widget _modalContent = Text('Content');

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _ModalTestWidget(
        modalKey: _modalKey,
      ),
    );

    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byKey(_modalKey), findsOneWidget);
  });

  testWidgets("Modal is displayed when the 'show' button is tapped.",
      (tester) async {
    await tester.pumpWidget(const _ModalTestWidget());
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_modalContent), findsOneWidget);
  });

  testWidgets(
      "Modal closes when a tap occurs outside its content, if dismissible.", (
    tester,
  ) async {
    await tester.pumpWidget(const _ModalTestWidget());
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_modalContent), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(_modalContent), findsNothing);
  });

  testWidgets(
      "Modal stays visible when a tap occurs outside its content,"
      " if not dismissible.", (tester) async {
    await tester.pumpWidget(
      const _ModalTestWidget(
        isDismissible: false,
      ),
    );
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_modalContent), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(_modalContent), findsOneWidget);
  });

  testWidgets("Modal closes when the 'close' button is tapped.",
      (tester) async {
    await tester.pumpWidget(const _ModalTestWidget());
    final button = find.byKey(_showButtonKey);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_modalContent), findsOneWidget);

    await tester.tap(find.byKey(_closeButtonKey));
    await tester.pumpAndSettle();

    expect(find.byWidget(_modalContent), findsNothing);
  });
}

class _ModalTestWidget extends StatelessWidget {
  final Key? modalKey;
  final bool isDismissible;

  const _ModalTestWidget({
    this.modalKey,
    this.isDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (context) {
              return MoonFilledButton(
                key: _showButtonKey,
                onTap: () => modalBuilder(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> modalBuilder(BuildContext context) {
    return showMoonModal<void>(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: Directionality.of(context),
          child: MoonModal(
            key: modalKey,
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  _modalContent,
                  MoonFilledButton(
                    key: _closeButtonKey,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
