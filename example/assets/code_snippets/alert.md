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
                    title: const Text("Base MoonAlert"),
                    trailing: MoonButton.icon(
                        buttonSize: MoonButtonSize.xs,
                        onTap: () => {},
                        icon: const Icon(MoonIcons.controls_close_24_light),
                    ),
                    body: const Text("Here goes MoonAlert body"),
                ),
                MoonFilledAlert(
                    show: true,
                    color: context.moonColors!.chichi,
                    onTrailingTap: () => {},
                    leading: const Icon(MoonIcons.notifications_alert_24_light),
                    title: const Text("Filled error MoonAlert"),
                ),
                MoonOutlinedAlert(
                    show: true,
                    color: context.moonColors!.roshi,
                    onTrailingTap: () => {},
                    leading: const Icon(MoonIcons.generic_check_rounded_24_light),
                    title: const Text("Outlined success MoonAlert"),
                ),
            ],
        );
    }
}