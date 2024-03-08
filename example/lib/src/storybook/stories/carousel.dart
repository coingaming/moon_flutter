import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CarouselStory extends StatefulWidget {
  static const path = '/primitives/carousel';

  const CarouselStory({super.key});

  @override
  State<CarouselStory> createState() => _CarouselStoryState();
}

class _CarouselStoryState extends State<CarouselStory> {
  MoonCarouselScrollController carouselController = MoonCarouselScrollController();

  int selectedDot = 0;

  @override
  Widget build(BuildContext context) {
    final backgroundColorKnob = context.knobs.nullable.options(
      label: "Background color",
      description: "MoonColors variants for MoonCarousel item background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final itemExtentKnob = context.knobs.nullable.sliderInt(
      label: "itemExtent",
      description: "Extent for MoonCarousel item.",
      enabled: false,
      initial: 114,
      min: 1,
      max: MediaQuery.of(context).size.width.round(),
    );

    final gapKnob = context.knobs.nullable.sliderInt(
      label: "gap",
      description: "Gap between MoonCarousel items.",
      enabled: false,
      initial: 8,
      max: 64,
    );

    final anchorKnob = context.knobs.nullable.slider(
      label: "anchor",
      description: "Anchor placement for MoonCarousel.",
      enabled: false,
      initial: 0.04,
    );

    final velocityFactorKnob = context.knobs.nullable.slider(
      label: "velocityFactor",
      description: "Velocity factor for MoonCarousel.",
      enabled: false,
      min: 0.1,
      initial: 0.5,
    );

    final autoPlayKnob = context.knobs.boolean(
      label: "autoPlay",
      description: "Whether MoonCarousel is auto playing.",
    );

    final isCenteredKnob = context.knobs.boolean(
      label: "isCentered",
      description: "Whether MoonCarousel items are centered.",
    );

    final isLoopedKnob = context.knobs.boolean(
      label: "loop",
      description: "Whether MoonCarousel is looped (infinite scroll).",
    );

    final clampMaxExtentKnob = context.knobs.boolean(
      label: "clampMaxExtent",
      description: "Whether to clamp the maxExtent of MoonCarousel.",
      initial: true,
    );

    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
            child: Column(
              children: [
                const TextDivider(
                  text: "MoonCarousel",
                  paddingTop: 0,
                ),
                SizedBox(
                  height: 114,
                  child: OverflowBox(
                    maxWidth: constraints.maxWidth,
                    child: MoonCarousel(
                      gap: gapKnob?.toDouble() ?? 8,
                      velocityFactor: velocityFactorKnob ?? 0.5,
                      loop: isLoopedKnob,
                      autoPlay: autoPlayKnob,
                      isCentered: isCenteredKnob,
                      itemCount: 10,
                      itemExtent: itemExtentKnob?.toDouble() ?? 114,
                      anchor: anchorKnob ?? 16 / (constraints.maxWidth - 16),
                      clampMaxExtent: clampMaxExtentKnob,
                      itemBuilder: (BuildContext context, int itemIndex, int _) => Container(
                        decoration: ShapeDecoration(
                          color: backgroundColor ?? context.moonColors!.goku,
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
                const TextDivider(text: "Custom MoonCarousel with extras"),
                Column(
                  children: [
                    SizedBox(
                      height: 180,
                      child: OverflowBox(
                        maxWidth: constraints.maxWidth,
                        child: Stack(
                          children: [
                            MoonCarousel(
                              gap: 64,
                              itemCount: 5,
                              itemExtent: constraints.maxWidth - 64,
                              loop: isLoopedKnob,
                              autoPlay: autoPlayKnob,
                              controller: carouselController,
                              physics: const PageScrollPhysics(),
                              onIndexChanged: (int index) => setState(() => selectedDot = index),
                              itemBuilder: (BuildContext context, int itemIndex, int _) => Container(
                                decoration: ShapeDecoration(
                                  color: backgroundColor ?? context.moonColors!.goku,
                                  shape: MoonSquircleBorder(
                                    borderRadius: BorderRadius.circular(12).squircleBorderRadius(context),
                                  ),
                                ),
                                child: Center(
                                  child: Text("${itemIndex + 1}"),
                                ),
                              ),
                            ),
                            Align(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MoonButton.icon(
                                      buttonSize: MoonButtonSize.sm,
                                      showBorder: true,
                                      icon: Icon(
                                        Directionality.of(context) == TextDirection.ltr
                                            ? MoonIcons.controls_chevron_left_small_24_light
                                            : MoonIcons.controls_chevron_right_small_24_light,
                                      ),
                                      decoration: ShapeDecorationWithPremultipliedAlpha(
                                        color: context.moonColors!.goku,
                                        shadows: context.moonShadows!.sm,
                                        shape: MoonSquircleBorder(
                                          borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
                                        ),
                                      ),
                                      onTap: selectedDot == 0 && !isLoopedKnob
                                          ? null
                                          : () => carouselController.previousItem(),
                                    ),
                                    MoonButton.icon(
                                      buttonSize: MoonButtonSize.sm,
                                      showBorder: true,
                                      icon: Icon(
                                        Directionality.of(context) == TextDirection.ltr
                                            ? MoonIcons.controls_chevron_right_small_24_light
                                            : MoonIcons.controls_chevron_left_small_24_light,
                                      ),
                                      decoration: ShapeDecorationWithPremultipliedAlpha(
                                        color: context.moonColors!.goku,
                                        shadows: context.moonShadows!.sm,
                                        shape: MoonSquircleBorder(
                                          borderRadius: BorderRadius.circular(8).squircleBorderRadius(context),
                                        ),
                                      ),
                                      onTap: selectedDot == 4 && !isLoopedKnob
                                          ? null
                                          : () => carouselController.nextItem(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    MoonDotIndicator(
                      selectedDot: selectedDot,
                      dotCount: 5,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
