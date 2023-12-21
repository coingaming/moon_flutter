import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonButton(
          buttonSize: MoonButtonSize.sm,
          onTap: () {},
          leading: const Icon(MoonIcons.other_frame_24_light),
          label: const Text('MoonButton'),
          trailing: const Icon(MoonIcons.other_frame_24_light),
        ),
        MoonButton.icon(
          buttonSize: MoonButtonSize.sm,
          onTap: () {},
          icon: const Icon(MoonIcons.other_frame_24_light),
        ),
        MoonFilledButton(
          buttonSize: MoonButtonSize.sm,
          onTap: () {},
          leading: const Icon(MoonIcons.other_frame_24_light),
          label: const Text("MoonFilledButton"),
          trailing: const Icon(MoonIcons.other_frame_24_light),
        ),
        MoonOutlinedButton(
          buttonSize: MoonButtonSize.sm,
          onTap: () {},
          leading: const Icon(MoonIcons.other_frame_24_light),
          label: const Text("MoonOutlinedButton"),
          trailing: const Icon(MoonIcons.other_frame_24_light),
        ),
        MoonTextButton(
          buttonSize: MoonButtonSize.sm,
          onTap: () {},
          leading: const Icon(MoonIcons.other_frame_24_light),
          label: const Text("MoonTextButton"),
          trailing: const Icon(MoonIcons.other_frame_24_light),
        ),
      ],
    );
  }
}