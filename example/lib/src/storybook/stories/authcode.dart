import 'dart:async';

import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

// Broadcast is used as a hack to overcome Storybook stale state
final StreamController<ErrorAnimationType> errorStreamController = StreamController<ErrorAnimationType>.broadcast();

class AuthCodeStory extends Story {
  AuthCodeStory()
      : super(
          name: "AuthCode",
          builder: (context) {
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

            final selectedFillColorsKnob = context.knobs.nullable.options(
              label: "selectedFillColor",
              description: "MoonColors variants for selected MoonAuthCode input field.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final selectedFillColor = colorTable(context)[selectedFillColorsKnob ?? 40];

            final activeFillColorsKnob = context.knobs.nullable.options(
              label: "activeFillColor",
              description: "MoonColors variants for active MoonAuthCode input fields.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeFillColor = colorTable(context)[activeFillColorsKnob ?? 40];

            final inactiveFillColorsKnob = context.knobs.nullable.options(
              label: "inactiveFillColor",
              description: "MoonColors variants for inactive MoonAuthCode input fields.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final inactiveFillColor = colorTable(context)[inactiveFillColorsKnob ?? 40];

            final selectedBorderColorsKnob = context.knobs.nullable.options(
              label: "selectedBorderColor",
              description: "MoonColors variants for selected MoonAuthCode input field border.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final selectedBorderColor = colorTable(context)[selectedBorderColorsKnob ?? 40];

            final activeBorderColorsKnob = context.knobs.nullable.options(
              label: "activeBorderColor",
              description: "MoonColors variants for active MoonAuthCode input fields borders.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final activeBorderColor = colorTable(context)[activeBorderColorsKnob ?? 40];

            final inactiveBorderColorsKnob = context.knobs.nullable.options(
              label: "inactiveBorderColor",
              description: "MoonColors variants for inactive MoonAuthCode input fields borders.",
              enabled: false,
              initial: 0, // piccolo
              options: colorOptions,
            );

            final inactiveBorderColor = colorTable(context)[inactiveBorderColorsKnob ?? 40];

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

            return StatefulBuilder(
              builder: (context, setState) {
                return Center(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 64),
                        const TextDivider(text: "Disabled MoonAuthCode"),
                        const SizedBox(height: 32),
                        MoonAuthCode(
                          enabled: enableKnob,
                          enableInputFill: true,
                          authInputFieldCount: 4,
                          mainAxisAlignment: mainAxisAlignmentKnob ?? MainAxisAlignment.center,
                          borderRadius:
                              borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
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
                        const SizedBox(height: 32),
                        const TextDivider(text: "Active MoonAuthCode"),
                        const SizedBox(height: 32),
                        MoonAuthCode(
                          autoFocus: true,
                          enableInputFill: true,
                          mainAxisAlignment: mainAxisAlignmentKnob ?? MainAxisAlignment.center,
                          borderRadius:
                              borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
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
                        const SizedBox(height: 32),
                        const TextDivider(text: "Error MoonAuthCode"),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 95,
                          child: MoonAuthCode(
                            enableInputFill: true,
                            authInputFieldCount: 4,
                            mainAxisAlignment: mainAxisAlignmentKnob ?? MainAxisAlignment.center,
                            borderRadius:
                                borderRadiusKnob != null ? BorderRadius.circular(borderRadiusKnob.toDouble()) : null,
                            errorStreamController: errorStreamController,
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
                            onCompleted: (pin) {
                              if (pin != '9921') {
                                errorStreamController.add(
                                  errorAnimationKnob ? ErrorAnimationType.shake : ErrorAnimationType.noAnimation,
                                );
                              }
                            },
                            validator: (pin) {
                              if (pin?.length == 4 && pin != '9921') {
                                return 'Invalid authentication code. Please try again.';
                              }
                              return null;
                            },
                            errorBuilder: (context, errorText) {
                              return Align(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(errorText ?? ''),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 64),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
}
