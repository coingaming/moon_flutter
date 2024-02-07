import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Tooltip extends StatefulWidget {
  const Tooltip({super.key});

  @override
  State<Tooltip> createState() => _TooltipState();
}

class _TooltipState extends State<Tooltip> {
  bool showOnTap = false;

  @override
  Widget build(BuildContext context) {
    return MoonTooltip(
      show: showOnTap,
      content: const Text('This is MoonTooltip'),
      child: MoonFilledButton(
        buttonSize: MoonButtonSize.sm,
        onTap: () => setState(() => showOnTap = true),
        label: const Text("Show MoonTooltip"),
      ),
    );
  }
}