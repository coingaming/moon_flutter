import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxWidth: MediaQuery.of(context).size.width,
      minHeight: 110,
      maxHeight: 110,
      child: MoonCarousel(
        itemCount: 10,
        itemExtent: 110,
        itemBuilder: (BuildContext context, int itemIndex, int _) => Container(
          decoration: ShapeDecoration(
            color: context.moonColors!.goku,
            shape: MoonSquircleBorder(
              borderRadius: BorderRadius.circular(12).squircleBorderRadius(context),
            ),
          ),
          child: Center(
            child: Text("${itemIndex + 1}"),
          ),
        ),
      ),
    );
  }
}