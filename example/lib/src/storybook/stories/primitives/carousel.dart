import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_core/moon_core.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class CarouselStory extends StatefulWidget {
  static const path = '/primitives/carousel';

  const CarouselStory({super.key});

  @override
  State<CarouselStory> createState() => _CarouselStoryState();
}

class _CarouselStoryState extends State<CarouselStory> {
  MoonCarouselScrollController carouselController =
      MoonCarouselScrollController();

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

    Widget buildChild(int itemIndex) => Container(
          decoration: ShapeDecoration(
            color: backgroundColor ?? context.moonColors!.goku,
            shape: MoonBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Center(
            child: Text("${itemIndex + 1}"),
          ),
        );

    Widget carouselButton(bool isPrevious) => MoonButton.icon(
          buttonSize: MoonButtonSize.sm,
          showBorder: true,
          icon: Icon(
            (Directionality.of(context) == TextDirection.ltr) ^ isPrevious
                ? MoonIcons.controls_chevron_right_small_24_light
                : MoonIcons.controls_chevron_left_small_24_light,
          ),
          decoration: ShapeDecorationWithPremultipliedAlpha(
            color: context.moonColors!.goku,
            shadows: context.moonShadows!.sm,
            shape: MoonBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onTap: selectedDot == (isPrevious ? 0 : 4) && !isLoopedKnob
              ? null
              : () => isPrevious
                  ? carouselController.previousItem()
                  : carouselController.nextItem(),
        );

    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 64.0,
              horizontal: 16.0,
            ),
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
                      itemCount: 10,
                      loop: isLoopedKnob,
                      autoPlay: autoPlayKnob,
                      isCentered: isCenteredKnob,
                      gap: gapKnob?.toDouble() ?? 8,
                      clampMaxExtent: clampMaxExtentKnob,
                      velocityFactor: velocityFactorKnob ?? 0.5,
                      itemExtent: itemExtentKnob?.toDouble() ?? 114,
                      anchor: anchorKnob ?? 16 / (constraints.maxWidth - 16),
                      itemBuilder: (BuildContext _, int itemIndex, int __) =>
                          buildChild(itemIndex),
                    ),
                  ),
                ),
                const TextDivider(text: "Custom MoonCarousel with extras"),
                SizedBox(
                  height: 180,
                  child: OverflowBox(
                    maxWidth: constraints.maxWidth,
                    child: Stack(
                      children: [
                        MoonCarousel(
                          itemCount: 5,
                          gap: 64,
                          loop: isLoopedKnob,
                          autoPlay: autoPlayKnob,
                          itemExtent: constraints.maxWidth - 64,
                          physics: const PageScrollPhysics(),
                          controller: carouselController,
                          onIndexChanged: (int index) =>
                              setState(() => selectedDot = index),
                          itemBuilder:
                              (BuildContext _, int itemIndex, int __) =>
                                  buildChild(itemIndex),
                        ),
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                carouselButton(true),
                                carouselButton(false),
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
          );
        },
      ),
    );
  }
}
