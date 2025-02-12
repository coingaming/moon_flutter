import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ModalStory extends StatelessWidget {
  static const path = '/primitives/modal';

  const ModalStory({super.key});

  @override
  Widget build(BuildContext context) {
    final alignmentKnob = context.knobs.nullable.options(
      label: "alignment",
      description: "Alignment for MoonModal.",
      enabled: false,
      initial: AlignmentDirectional.center,
      options: const [
        Option(label: "center", value: AlignmentDirectional.center),
        Option(label: "centerStart", value: AlignmentDirectional.centerStart),
        Option(label: "centerEnd", value: AlignmentDirectional.centerEnd),
        Option(label: "topCenter", value: AlignmentDirectional.topCenter),
        Option(label: "topStart", value: AlignmentDirectional.topStart),
        Option(label: "topEnd", value: AlignmentDirectional.topEnd),
        Option(label: "bottomCenter", value: AlignmentDirectional.bottomCenter),
        Option(label: "bottomStart", value: AlignmentDirectional.bottomStart),
        Option(label: "bottomEnd", value: AlignmentDirectional.bottomEnd),
      ],
    );

    final textColorKnob = context.knobs.nullable.options(
      label: "Text color",
      description: "MoonColors variants for MoonModal text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonModal background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final barrierColorKnob = context.knobs.nullable.options(
      label: "barrierColor",
      description: "MoonColors variants for MoonModal barrier.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final barrierColor = colorTable(context)[barrierColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonModal.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final barrierDismissibleKnob = context.knobs.boolean(
      label: "barrierDismissible",
      description: "Modal barrier is dismissible via barrier taps.",
      initial: true,
    );

    Future<void> modalBuilder(BuildContext context) {
      return showMoonModal<void>(
        context: context,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissibleKnob,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: Directionality.of(context),
            child: MoonModal(
              alignment: alignmentKnob,
              backgroundColor: backgroundColor,
              borderRadius: borderRadiusKnob != null
                  ? BorderRadius.circular(borderRadiusKnob.toDouble())
                  : null,
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                      child: Text(
                        "MoonModal title",
                        style: context.moonTypography!.heading.text18
                            .copyWith(color: textColor),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: context.moonColors!.trunks,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                      child: Text(
                        "Re-open the MoonModal to view the updated knob value.",
                        style: context.moonTypography!.body.text14
                            .copyWith(color: textColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                      child: MoonFilledButton(
                        label: const Text("Okay"),
                        isFullWidth: true,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Center(
      child: Builder(
        builder: (BuildContext context) {
          return MoonFilledButton(
            label: const Text("Tap me"),
            onTap: () => modalBuilder(context),
          );
        },
      ),
    );
  }
}
