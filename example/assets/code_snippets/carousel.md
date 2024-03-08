import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int selectedDot = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Default MoonCarousel.
        SizedBox(
          height: 110,
          child: OverflowBox(
            maxWidth: MediaQuery.of(context).size.width,
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
          ),
        ),

        // Full width MoonCarousel with MoonDotIndicator.
        Column(
          children: [
            SizedBox(
              height: 180,
              child: OverflowBox(
                maxWidth: MediaQuery.of(context).size.width,
                child: MoonCarousel(
                  gap: 32,
                  itemCount: 5,
                  itemExtent: MediaQuery.of(context).size.width - 32,
                  physics: const PageScrollPhysics(),
                  onIndexChanged: (int index) => setState(() => selectedDot = index),
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
              ),
            ),
            MoonDotIndicator(
              selectedDot: selectedDot,
              dotCount: 5,
            ),
          ],
        ),
      ],
    );
  }
}
