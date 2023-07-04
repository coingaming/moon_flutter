import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CarouselStory extends Story {
  CarouselStory()
      : super(
          name: "Carousel",
          builder: (context) {
            final textColorsKnob = context.knobs.nullable.options(
              label: "Text color",
              description: "MoonColors variants for MoonModal text.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final textColor = colorTable(context)[textColorsKnob ?? 40];

            final backgroundColorsKnob = context.knobs.nullable.options(
              label: "backgroundColor",
              description: "MoonColors variants for MoonModal background.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final backgroundColor = colorTable(context)[backgroundColorsKnob ?? 40];

            final barrierColorsKnob = context.knobs.nullable.options(
              label: "barrierColor",
              description: "MoonColors variants for MoonModal barrier.",
              enabled: false,
              initial: 0,
              // piccolo
              options: colorOptions,
            );

            final barrierColor = colorTable(context)[barrierColorsKnob ?? 40];

            final borderRadiusKnob = context.knobs.nullable.sliderInt(
              label: "borderRadius",
              description: "Border radius for MoonModal.",
              enabled: false,
              initial: 8,
              max: 32,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  Container(
                    color: Colors.red.withOpacity(0.2),
                    height: 300,
                    child: MoonCarousel(
                      //controller: carouselController,
                      autoPlay: false,
                      itemCount: 5,
                      itemExtent: 300,
                      loop: false,
                      isItemAlwaysCentered: true,
                      itemBuilder: (context, itemIndex, realIndex) => Container(
                        color: Colors.blue,
                        child: Center(
                          child: Text(itemIndex.toString()),
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
