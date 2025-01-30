import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class DotIndicatorStory extends StatefulWidget {
  static const path = '/primitives/dot_indicator';

  const DotIndicatorStory({super.key});

  @override
  State<DotIndicatorStory> createState() => _DotIndicatorStoryState();
}

class _DotIndicatorStoryState extends State<DotIndicatorStory> {
  int _selectedDot = 0;

  @override
  Widget build(BuildContext context) {
    final selectedColorKnob = context.knobs.nullable.options(
      label: "selectedColor",
      description: "MoonColors variants for MoonDotIndicator selected dot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final selectedColor = colorTable(context)[selectedColorKnob ?? 40];

    final unselectedColorKnob = context.knobs.nullable.options(
      label: "unselectedColor",
      description: "MoonColors variants for MoonDotIndicator unselected dot.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final unselectedColor = colorTable(context)[unselectedColorKnob ?? 40];

    final sizeKnob = context.knobs.nullable.sliderInt(
      label: "size",
      description: "Dot size for MoonDotIndicator.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final gapKnob = context.knobs.nullable.sliderInt(
      label: "gap",
      description: "Gap between MoonDotIndicator dots.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoonDotIndicator(
              dotCount: 4,
              selectedDot: _selectedDot,
              size: sizeKnob?.toDouble(),
              gap: gapKnob?.toDouble(),
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (int index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: MoonFilledButton(
                    label: Text("${index + 1}"),
                    onTap: () => setState(() => _selectedDot = index),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
