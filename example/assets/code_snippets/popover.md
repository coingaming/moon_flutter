import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Popover extends StatefulWidget {
  const Popover({super.key});

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return MoonPopover(
      show: show,
      onTapOutside: () => setState(() => show = false),
      content: const Text('This is MoonPopover'),
      child: MoonFilledButton(
        onTap: () => setState(() => show = !show),
        label: const Text("Show MoonPopover"),
      ),
    );
  }
}