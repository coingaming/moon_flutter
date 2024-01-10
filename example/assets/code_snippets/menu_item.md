import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({super.key});

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return MoonMenuItem(
      onTap: () {},
      label: const Text("Menu Item"),
      leading: const Icon(MoonIcons.notifications_activity_32_regular),
      trailing: const Icon(MoonIcons.controls_chevron_right_24_light),
    );
  }
}