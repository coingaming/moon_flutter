import 'package:example/src/storybook/common/color_options.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class ToastStory extends StatelessWidget {
  static const path = '/primitives/toast';

  const ToastStory({super.key});

  @override
  Widget build(BuildContext context) {
    final customLabelTextKnob = context.knobs.text(
      label: "MoonToast label text",
      initial: "Custom MoonToast text",
    );

    final toastAlignmentKnob = context.knobs.nullable.options(
      label: "toastAlignment",
      description: "Alignment (position) for MoonToast.",
      enabled: false,
      initial: Alignment.bottomCenter,
      options: const [
        Option(label: "topLeft", value: Alignment.topLeft),
        Option(label: "topCenter", value: Alignment.topCenter),
        Option(label: "topRight", value: Alignment.topRight),
        Option(label: "centerLeft", value: Alignment.centerLeft),
        Option(label: "center", value: Alignment.center),
        Option(label: "centerRight", value: Alignment.centerRight),
        Option(label: "bottomLeft", value: Alignment.bottomLeft),
        Option(label: "bottomCenter", value: Alignment.bottomCenter),
        Option(label: "bottomRight", value: Alignment.bottomRight),
      ],
    );

    final toastVariantKnob = context.knobs.nullable.options(
      label: "variant",
      description: "The color variant for MoonToast.",
      enabled: false,
      initial: MoonToastVariant.original,
      options: const [
        Option(label: "original", value: MoonToastVariant.original),
        Option(label: "inverted", value: MoonToastVariant.inverted),
      ],
    );

    final textColorKnob = context.knobs.nullable.options(
      label: "Text color",
      description: "MoonColors variants for MoonToast text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final iconColorKnob = context.knobs.nullable.options(
      label: "Icon color",
      description: "MoonColors variants for MoonToast icon.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final iconColor = colorTable(context)[iconColorKnob ?? 40];

    final backgroundColorKnob = context.knobs.nullable.options(
      label: "backgroundColor",
      description: "MoonColors variants for MoonToast background.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final backgroundColor = colorTable(context)[backgroundColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonToast.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final displayDurationKnob = context.knobs.nullable.sliderInt(
      label: "displayDuration",
      description: "Display duration for MoonToast.",
      enabled: false,
      initial: 3,
      min: 1,
      max: 10,
    );

    final widthKnob = context.knobs.nullable.slider(
      label: "width",
      description:
          "Width for MoonToast. If null, the toast will be as wide as its "
          "children.",
      enabled: false,
      initial: 230,
      max: MediaQuery.of(context).size.width,
    );

    final isPersistentKnob = context.knobs.boolean(
      label: "isPersistent",
      description:
          "Whether MoonToast is persistent across screens (will not behave as "
          "expected only in Storybook).",
    );

    final useSafeAreaKnob = context.knobs.boolean(
      label: "useSafeArea",
      description:
          "Whether MoonToast respects the SafeArea (takes into account notches "
          "and native system bars).",
      initial: true,
    );

    final showContentKnob = context.knobs.boolean(
      label: "content",
      description: "Show widget in MoonToast content slot.",
    );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64),
        child: Builder(
          builder: (BuildContext context) {
            return MoonFilledButton(
              label: const Text("Tap me"),
              onTap: () {
                MoonToast.show(
                  context,
                  backgroundColor: backgroundColor,
                  isPersistent: isPersistentKnob,
                  useSafeArea: useSafeAreaKnob,
                  width: widthKnob,
                  toastAlignment: toastAlignmentKnob ?? Alignment.bottomCenter,
                  variant: toastVariantKnob ?? MoonToastVariant.original,
                  displayDuration: displayDurationKnob != null
                      ? Duration(seconds: displayDurationKnob)
                      : null,
                  borderRadius: borderRadiusKnob != null
                      ? BorderRadius.circular(borderRadiusKnob.toDouble())
                      : null,
                  leading: Icon(
                    MoonIcons.generic_info_24_light,
                    color: iconColor,
                  ),
                  label: Text(
                    customLabelTextKnob,
                    style: TextStyle(color: textColor),
                  ),
                  trailing: Icon(
                    MoonIcons.generic_star_24_light,
                    color: iconColor,
                  ),
                  content: showContentKnob
                      ? Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "Here goes MoonToast content",
                            style: TextStyle(color: textColor),
                          ),
                        )
                      : null,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
