import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Alert extends StatelessWidget {
  const Alert({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MoonAlert(
          show: true,
          leading: const Icon(MoonIcons.other_frame_24_light),
          label: const Text("Base MoonAlert"),
          trailing: MoonButton.icon(
            buttonSize: MoonButtonSize.xs,
            onTap: () => {},
            icon: const Icon(MoonIcons.controls_close_24_light),
          ),
          content: const Text("Here goes MoonAlert content"),
        ),
        MoonAlert.filled(
          show: true,
          color: context.moonColors!.chichi,
          backgroundColor: context.moonColors!.chichi10,
          leading: const Icon(MoonIcons.notifications_alert_24_light),
          label: const Text("Filled error MoonAlert"),
          trailing: MoonButton.icon(
            buttonSize: MoonButtonSize.xs,
            onTap: () {},
            icon: Icon(
              MoonIcons.controls_close_small_24_light,
              color: context.moonColors!.chichi,
            ),
          ),
        ),
        MoonAlert.outlined(
          show: true,
          color: context.moonColors!.roshi,
          borderColor: context.moonColors!.roshi,
          leading: const Icon(MoonIcons.generic_check_rounded_24_light),
          label: const Text("Outlined success MoonAlert"),
          trailing: MoonButton.icon(
            buttonSize: MoonButtonSize.xs,
            onTap: () {},
            icon: Icon(
              MoonIcons.controls_close_small_24_light,
              color: context.moonColors!.roshi,
            ),
          ),
        ),
      ],
    );
  }
}