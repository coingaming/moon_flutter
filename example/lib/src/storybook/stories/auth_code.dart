import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class AuthCodeStory extends StatelessWidget {
  static const path = '/auth_code';

  const AuthCodeStory({super.key});

  @override
  Widget build(BuildContext context) {
    final mainAxisAlignmentKnob = context.knobs.nullable.options(
      label: "mainAxisAlignment",
      description: "Horizontal alignment of MoonAuthCode input fields.",
      enabled: false,
      initial: MainAxisAlignment.center,
      options: const [
        Option(label: "start", value: MainAxisAlignment.start),
        Option(label: "center", value: MainAxisAlignment.center),
        Option(label: "end", value: MainAxisAlignment.end),
        Option(label: "spaceBetween", value: MainAxisAlignment.spaceBetween),
        Option(label: "spaceAround", value: MainAxisAlignment.spaceAround),
        Option(label: "spaceEvenly", value: MainAxisAlignment.spaceEvenly),
      ],
    );

    final shapeKnob = context.knobs.nullable.options(
      label: "shape",
      description: "Shape of the MoonAuthCode input fields.",
      enabled: false,
      initial: AuthFieldShape.box,
      options: const [
        Option(label: "box", value: AuthFieldShape.box),
        Option(label: "circle", value: AuthFieldShape.circle),
        Option(label: "underline", value: AuthFieldShape.underline),
      ],
    );

    final textColorKnob = context.knobs.nullable.options(
      label: "Text color",
      description: "MoonColors variants for MoonAuthCode text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final cursorColorKnob = context.knobs.nullable.options(
      label: "authFieldCursorColor",
      description: "MoonColors variants for MoonAuthCode cursor.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final cursorColor = colorTable(context)[cursorColorKnob ?? 40];

    final selectedFillColorKnob = context.knobs.nullable.options(
      label: "selectedFillColor",
      description: "MoonColors variants for selected MoonAuthCode input field.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final selectedFillColor = colorTable(context)[selectedFillColorKnob ?? 40];

    final activeFillColorKnob = context.knobs.nullable.options(
      label: "activeFillColor",
      description: "MoonColors variants for active MoonAuthCode input fields.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeFillColor = colorTable(context)[activeFillColorKnob ?? 40];

    final inactiveFillColorKnob = context.knobs.nullable.options(
      label: "inactiveFillColor",
      description: "MoonColors variants for inactive MoonAuthCode input fields.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final inactiveFillColor = colorTable(context)[inactiveFillColorKnob ?? 40];

    final selectedBorderColorKnob = context.knobs.nullable.options(
      label: "selectedBorderColor",
      description: "MoonColors variants for selected MoonAuthCode input field border.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final selectedBorderColor = colorTable(context)[selectedBorderColorKnob ?? 40];

    final activeBorderColorKnob = context.knobs.nullable.options(
      label: "activeBorderColor",
      description: "MoonColors variants for active MoonAuthCode input fields borders.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final activeBorderColor = colorTable(context)[activeBorderColorKnob ?? 40];

    final inactiveBorderColorKnob = context.knobs.nullable.options(
      label: "inactiveBorderColor",
      description: "MoonColors variants for inactive MoonAuthCode input fields borders.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final inactiveBorderColor = colorTable(context)[inactiveBorderColorKnob ?? 40];

    final borderRadiusKnob = context.knobs.nullable.sliderInt(
      label: "borderRadius",
      description: "Border radius for MoonAuthCode input fields.",
      enabled: false,
      initial: 8,
      max: 32,
    );

    final gapKnob = context.knobs.nullable.sliderInt(
      label: "gap",
      description: "Gap between MoonAuthCode input fields.",
      enabled: false,
      initial: 8,
      max: 12,
    );

    final enableKnob = context.knobs.boolean(
      label: "enabled",
      description: "Enable MoonAuthCode.",
    );

    final obscuringKnob = context.knobs.boolean(
      label: "obscureText",
      description: "Obscure MoonAuthCode input fields.",
    );

    final peekWhenObscuringKnob = context.knobs.boolean(
      label: "peekWhenObscuring",
      description: "Peek when obscuring.",
    );

    final errorAnimationKnob = context.knobs.boolean(
      label: "Error shake animation",
      description: "Show error with shake animation (ErrorAnimationType.shake).",
    );

    final BorderRadiusGeometry? borderRadius =
        borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 64.0, horizontal: 16.0),
        child: Column(
          children: [
            const TextDivider(
              text: "Disabled MoonAuthCode",
              paddingTop: 0,
            ),
            MoonAuthCode(
              enabled: enableKnob,
              enableInputFill: true,
              authInputFieldCount: 4,
              mainAxisAlignment: mainAxisAlignmentKnob ?? MainAxisAlignment.center,
              borderRadius: borderRadius,
              textStyle: TextStyle(color: textColor),
              authFieldCursorColor: cursorColor,
              selectedFillColor: selectedFillColor,
              activeFillColor: activeFillColor,
              inactiveFillColor: inactiveFillColor,
              selectedBorderColor: selectedBorderColor,
              activeBorderColor: activeBorderColor,
              inactiveBorderColor: inactiveBorderColor,
              gap: gapKnob?.toDouble(),
              authFieldShape: shapeKnob,
              obscureText: obscuringKnob,
              peekWhenObscuring: peekWhenObscuringKnob,
              validator: (String? value) => null,
              errorBuilder: (BuildContext context, String? errorText) => const SizedBox(),
            ),
            const TextDivider(text: "Active MoonAuthCode"),
            MoonAuthCode(
              autoFocus: true,
              enableInputFill: true,
              mainAxisAlignment: mainAxisAlignmentKnob ?? MainAxisAlignment.center,
              borderRadius: borderRadius,
              textStyle: TextStyle(color: textColor),
              authFieldCursorColor: cursorColor,
              selectedFillColor: selectedFillColor,
              activeFillColor: activeFillColor,
              inactiveFillColor: inactiveFillColor,
              selectedBorderColor: selectedBorderColor,
              activeBorderColor: activeBorderColor,
              inactiveBorderColor: inactiveBorderColor,
              gap: gapKnob?.toDouble(),
              authFieldShape: shapeKnob,
              obscureText: obscuringKnob,
              peekWhenObscuring: peekWhenObscuringKnob,
              validator: (String? value) => null,
              errorBuilder: (BuildContext context, String? errorText) => const SizedBox(),
            ),
            const TextDivider(text: "Error MoonAuthCode"),
            SizedBox(
              height: 95,
              child: MoonAuthCode(
                enableInputFill: true,
                authInputFieldCount: 4,
                mainAxisAlignment: mainAxisAlignmentKnob ?? MainAxisAlignment.center,
                errorAnimationType: errorAnimationKnob ? ErrorAnimationType.shake : ErrorAnimationType.noAnimation,
                borderRadius: borderRadius,
                textStyle: TextStyle(color: textColor),
                authFieldCursorColor: cursorColor,
                selectedFillColor: selectedFillColor,
                activeFillColor: activeFillColor,
                inactiveFillColor: inactiveFillColor,
                selectedBorderColor: selectedBorderColor,
                activeBorderColor: activeBorderColor,
                inactiveBorderColor: inactiveBorderColor,
                gap: gapKnob?.toDouble(),
                authFieldShape: shapeKnob,
                obscureText: obscuringKnob,
                peekWhenObscuring: peekWhenObscuringKnob,
                validator: (String? pin) {
                  // Matches all numbers
                  final RegExp regex = RegExp(r'^\d+$');

                  return pin != null && pin.length == 4 && !regex.hasMatch(pin)
                      ? 'The input must only contain numbers'
                      : null;
                },
                errorBuilder: (BuildContext context, String? errorText) {
                  return Align(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(errorText ?? ''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
