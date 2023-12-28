import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

void main() {
  const key = Key("button_test");

  testWidgets(
    "Provided key is used",
    (tester) async {
      await tester.pumpWidget(
        const CarouselTestWidget(
          widgetKey: key,
        ),
      );
      expect(find.byKey(key), findsOneWidget);
    },
  );

  testWidgets(
    "Test scroll",
    (tester) async {
      await tester.pumpWidget(
        const CarouselTestWidget(
          widgetKey: key,
        ),
      );
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);
      expect(find.text('3'), findsNothing);
      await tester.drag(find.byKey(key), const Offset(-150, 0));
      await tester.pumpAndSettle();
      expect(find.text('1'), findsNothing);
      expect(find.text('3'), findsOneWidget);
    },
  );
}

class CarouselTestWidget extends StatelessWidget {
  final Key? widgetKey;

  const CarouselTestWidget({super.key, this.widgetKey});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SizedBox(
        height: 114,
        width: 200,
        child: MoonCarousel(
          key: widgetKey,
          gap: 8,
          itemCount: 10,
          itemExtent: 100,
          itemBuilder: (BuildContext context, int itemIndex, int realIndex) =>
              Container(
            height: 100,
            width: 100,
            decoration: ShapeDecoration(
              color: context.moonColors?.goku,
              shape: MoonSquircleBorder(
                borderRadius:
                    BorderRadius.circular(12).squircleBorderRadius(context),
              ),
            ),
            child: Center(
              child: Text("${itemIndex + 1}"),
            ),
          ),
        ),
      ),
    ));
  }
}
