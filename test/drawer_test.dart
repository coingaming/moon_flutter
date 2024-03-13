import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _drawerKey = Key("drawerKey");
const Key _openButtonKey = Key("openButtonKey");
const Key _closeButtonKey = Key("closeButtonKey");

const Widget _drawerContent = Text("Content");

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _DrawerTestWidget(
        drawerKey: _drawerKey,
      ),
    );

    final button = find.byKey(_openButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byKey(_drawerKey), findsOneWidget);
  });

  testWidgets("Drawer is displayed when the open button is tapped.", (tester) async {
    await tester.pumpWidget(const _DrawerTestWidget());

    final button = find.byKey(_openButtonKey);

    expect(button, findsOneWidget);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsOneWidget);
  });

  testWidgets("Drawer closes when a tap occurs outside its content.", (tester) async {
    await tester.pumpWidget(const _DrawerTestWidget());

    final button = find.byKey(_openButtonKey);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsOneWidget);

    await tester.tapAt(const Offset(210, 10));
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsNothing);
  });

  testWidgets("Drawer closes when the 'close' button is tapped.", (tester) async {
    await tester.pumpWidget(const _DrawerTestWidget());

    final button = find.byKey(_openButtonKey);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsOneWidget);

    await tester.tap(find.byKey(_closeButtonKey));
    await tester.pumpAndSettle();

    expect(find.byWidget(_drawerContent), findsNothing);
  });
}

class _DrawerTestWidget extends StatelessWidget {
  final Key? drawerKey;

  const _DrawerTestWidget({this.drawerKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MoonDrawer(
          key: drawerKey,
          width: 200,
          child: Column(
            children: [
              _drawerContent,
              Builder(
                builder: (BuildContext context) {
                  return MoonFilledButton(
                    key: _closeButtonKey,
                    onTap: () => Navigator.of(context).pop(),
                  );
                },
              ),
            ],
          ),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return MoonFilledButton(
              key: _openButtonKey,
              onTap: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
    );
  }
}
