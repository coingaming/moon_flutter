import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _bottomSheetKey = Key("bottomSheetKey");
const Key _showButtonKey = Key("showButtonKey");

const Widget _bottomSheetContent = Text("Content");

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _BottomSheetTestWidget(
        key: _bottomSheetKey,
      ),
    );
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byKey(_bottomSheetKey), findsOneWidget);
  });

  testWidgets("Bottom sheet is displayed when the 'show' button is tapped.", (tester) async {
    await tester.pumpWidget(const _BottomSheetTestWidget());
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_bottomSheetContent), findsOneWidget);
  });

  testWidgets("Bottom sheet closes when a tap occurs outside its content, if dismissible.", (tester) async {
    await tester.pumpWidget(const _BottomSheetTestWidget());
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_bottomSheetContent), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(_bottomSheetContent), findsNothing);
  });

  testWidgets("Bottom sheet stays visible when a tap occurs outside its content, if not dismissible.", (tester) async {
    await tester.pumpWidget(
      const _BottomSheetTestWidget(
        isDismissible: false,
      ),
    );
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_bottomSheetContent), findsOneWidget);

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(_bottomSheetContent), findsOneWidget);
  });

  testWidgets("Bottom sheet is expanded.", (tester) async {
    await tester.pumpWidget(
      const _BottomSheetTestWidget(
        isExpanded: true,
      ),
    );
    final button = find.byKey(_showButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_bottomSheetContent), findsOneWidget);

    await tester.tapAt(const Offset(1, 1));
    await tester.pumpAndSettle();

    expect(find.byWidget(_bottomSheetContent), findsOneWidget);

    await tester.tapAt(const Offset(100, 1));
    await tester.pumpAndSettle();

    expect(find.byWidget(_bottomSheetContent), findsOneWidget);
  });
}

class _BottomSheetTestWidget extends StatelessWidget {
  final bool isDismissible;
  final bool isExpanded;

  const _BottomSheetTestWidget({
    super.key,
    this.isDismissible = true,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return MoonFilledButton(
              key: _showButtonKey,
              onTap: () => bottomSheetBuilder(context),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> bottomSheetBuilder(BuildContext context) {
    return showMoonModalBottomSheet(
      context: context,
      isExpanded: isExpanded,
      isDismissible: isDismissible,
      builder: (BuildContext context) => _bottomSheetContent,
    );
  }
}
