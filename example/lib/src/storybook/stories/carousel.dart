import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CarouselStory extends Story {
  CarouselStory()
      : super(
          name: "Carousel",
          builder: (context) {
            final itemExtentKnob = context.knobs.nullable.sliderInt(
              label: "itemExtent",
              description: "MoonCarousel item extent.",
              enabled: false,
              initial: 120,
              max: MediaQuery.of(context).size.width.round(),
            );

            final gapKnob = context.knobs.nullable.sliderInt(
              label: "gap",
              description: "The gap between MoonCarousel items.",
              enabled: false,
              initial: 0,
              max: 64,
            );

            final anchorKnob = context.knobs.nullable.slider(
              label: "anchor",
              description: "MoonCarousel anchor placement.",
              enabled: false,
              initial: 0,
            );

            final velocityFactorKnob = context.knobs.nullable.slider(
              label: "velocityFactor",
              description: "The velocity factor for MoonCarousel.",
              enabled: false,
              min: 0.1,
              initial: 0.5,
            );

            final autoPlayKnob = context.knobs.boolean(
              label: "autoPlay",
              description: "Whether the MoonCarousel is auto playing.",
            );

            final isCenteredKnob = context.knobs.boolean(
              label: "isCentered",
              description: "Whether the MoonCarousel items are centered.",
              initial: true,
            );

            final isLoopedKnob = context.knobs.boolean(
              label: "loop",
              description: "Whether the MoonCarousel is looped or not (infinite scroll).",
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  SizedBox(
                    height: 120,
                    child: OverflowBox(
                      maxWidth: MediaQuery.of(context).size.width,
                      child: MoonCarousel(
                        velocityFactor: velocityFactorKnob ?? 0.5,
                        gap: gapKnob?.toDouble() ?? 8,
                        //controller: carouselController,
                        autoPlay: autoPlayKnob,
                        itemCount: 10,
                        itemExtent: itemExtentKnob?.toDouble() ?? 120,
                        isCentered: isCenteredKnob,
                        anchor: anchorKnob ?? 0,
                        loop: isLoopedKnob,
                        itemBuilder: (context, itemIndex, realIndex) => Container(
                          decoration: ShapeDecoration(
                            color: context.moonColors!.gohan,
                            shape: MoonSquircleBorder(
                              borderRadius: BorderRadius.circular(12).squircleBorderRadius(context),
                            ),
                          ),
                          child: Center(
                            child: Text(itemIndex.toString()),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        );
}
