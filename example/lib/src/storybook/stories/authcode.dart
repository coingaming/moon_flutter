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
            final mainAxisAlignmentKnob = context.knobs.options(
              label: "mainAxisAlignment",
              description: "Horizontal alignment of auth input fields.",
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

            final shapeKnob = context.knobs.options(
              label: "shape",
              description: "Shape of the auth input fields.",
              initial: AuthFieldShape.box,
              options: const [
                Option(label: "box", value: AuthFieldShape.box),
                Option(label: "circle", value: AuthFieldShape.circle),
                Option(label: "underline", value: AuthFieldShape.underline),
              ],
            );

            final selectedFillColorsKnob = context.knobs.options(
              label: "selectedFillColor",
              description: "MoonColors variants for selected auth input field.",
              initial: 40, // null
              options: colorOptions,
            );

            final selectedFillColor = colorTable(context)[selectedFillColorsKnob];

            final activeFillColorsKnob = context.knobs.options(
              label: "activeFillColor",
              description: "MoonColors variants for active auth input fields.",
              initial: 40, // null
              options: colorOptions,
            );

            final activeFillColor = colorTable(context)[activeFillColorsKnob];

            final inactiveFillColorsKnob = context.knobs.options(
              label: "inactiveFillColor",
              description: "MoonColors variants for inactive auth input fields.",
              initial: 40, // null
              options: colorOptions,
            );

            final inactiveFillColor = colorTable(context)[inactiveFillColorsKnob];

            final selectedBorderColorsKnob = context.knobs.options(
              label: "selectedBorderColor",
              description: "MoonColors variants for selected auth input field border.",
              initial: 40, // null
              options: colorOptions,
            );

            final selectedBorderColor = colorTable(context)[selectedBorderColorsKnob];

            final activeBorderColorsKnob = context.knobs.options(
              label: "activeBorderColor",
              description: "MoonColors variants for active auth input fields borders.",
              initial: 40, // null
              options: colorOptions,
            );

            final activeBorderColor = colorTable(context)[activeBorderColorsKnob];

            final inactiveBorderColorsKnob = context.knobs.options(
              label: "inactiveBorderColor",
              description: "MoonColors variants for inactive auth input fields borders.",
              initial: 40, // null
              options: colorOptions,
            );

            final inactiveBorderColor = colorTable(context)[inactiveBorderColorsKnob];

            final borderRadiusKnob = context.knobs.sliderInt(
              max: 12,
              initial: 8,
              label: "borderRadius",
              description: "Border radius for auth input fields.",
            );

            final gapKnob = context.knobs.sliderInt(
              max: 12,
              initial: 8,
              label: "gap",
              description: "Gap between auth input fields.",
            );

            final enableKnob = context.knobs.boolean(
              label: "enabled",
              description: "Enable AuthCode.",
            );

            final obscuringKnob = context.knobs.boolean(
              label: "obscureText",
              description: "Obscure auth input fields.",
            );

            final peekWhenObscuringKnob = context.knobs.boolean(
              label: "peekWhenObscuring",
              description: "Peek when obscuring.",
            );

            final errorAnimationKnob = context.knobs.boolean(
              label: "Error shake animation",
              description: "Show error with shake animation (ErrorAnimationType.shake).",
            );

            final setRtlModeKnob = context.knobs.boolean(
              label: "RTL mode",
              description: "Switch between LTR and RTL modes.",
            );

            return StatefulBuilder(
              builder: (context, setState) {
                return Directionality(
                  textDirection: setRtlModeKnob ? TextDirection.rtl : TextDirection.ltr,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      const TextDivider(text: "Disabled MoonAuthCode"),
                      const SizedBox(height: 32),
                      MoonAuthCode(
                        enableInputFill: true,
                        authInputFieldCount: 4,
                        mainAxisAlignment: mainAxisAlignmentKnob,
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                        selectedFillColor: selectedFillColor,
                        activeFillColor: activeFillColor,
                        inactiveFillColor: inactiveFillColor,
                        selectedBorderColor: selectedBorderColor,
                        activeBorderColor: activeBorderColor,
                        inactiveBorderColor: inactiveBorderColor,
                        enabled: enableKnob,
                        gap: gapKnob.toDouble(),
                        authFieldShape: shapeKnob,
                        obscureText: obscuringKnob,
                        obscuringCharacter: '﹡',
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
                        mainAxisAlignment: mainAxisAlignmentKnob,
                        borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                        selectedFillColor: selectedFillColor,
                        activeFillColor: activeFillColor,
                        inactiveFillColor: inactiveFillColor,
                        selectedBorderColor: selectedBorderColor,
                        activeBorderColor: activeBorderColor,
                        inactiveBorderColor: inactiveBorderColor,
                        gap: gapKnob.toDouble(),
                        authFieldShape: shapeKnob,
                        obscureText: obscuringKnob,
                        obscuringCharacter: '﹡',
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
                          mainAxisAlignment: mainAxisAlignmentKnob,
                          borderRadius: BorderRadius.circular(borderRadiusKnob.toDouble()),
                          errorStreamController: errorStreamController,
                          selectedFillColor: selectedFillColor,
                          activeFillColor: activeFillColor,
                          inactiveFillColor: inactiveFillColor,
                          selectedBorderColor: selectedBorderColor,
                          activeBorderColor: activeBorderColor,
                          inactiveBorderColor: inactiveBorderColor,
                          gap: gapKnob.toDouble(),
                          authFieldShape: shapeKnob,
                          obscureText: obscuringKnob,
                          obscuringCharacter: '﹡',
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
                );
              },
            );
          },
        );
}
