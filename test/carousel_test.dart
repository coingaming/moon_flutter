import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_design/moon_design.dart';

const Key _carouselKey = Key("carouselKey");

void main() {
  testWidgets("Provided key is used.", (tester) async {
    await tester.pumpWidget(
      const _CarouselTestWidget(
        carouselKey: _carouselKey,
      ),
    );

    expect(find.byKey(_carouselKey), findsOneWidget);
  });

  testWidgets("Carousel items visibility changes on scroll.", (tester) async {
    await tester
        .pumpWidget(const _CarouselTestWidget(carouselKey: _carouselKey));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsNothing);

    await tester.drag(find.byKey(_carouselKey), const Offset(-150, 0));
    await tester.pumpAndSettle();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsNothing);
  });
}

class _CarouselTestWidget extends StatelessWidget {
  final Key? carouselKey;

  const _CarouselTestWidget({this.carouselKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: 114,
          width: 200,
          child: MoonCarousel(
            key: carouselKey,
            gap: 0,
            itemCount: 10,
            itemExtent: 100,
            itemBuilder: (BuildContext _, int itemIndex, int __) =>
                Text("$itemIndex"),
          ),
        ),
      ),
    );
  }
}
