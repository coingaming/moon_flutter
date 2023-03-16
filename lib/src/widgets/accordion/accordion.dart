import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class MoonAccordion extends StatefulWidget {
  final Widget? icon;
  final Widget title;
  final List<Widget> children;

  const MoonAccordion({
    super.key,
    this.icon,
    required this.title,
    this.children = const <Widget>[],
  });

  @override
  State<MoonAccordion> createState() => _MoonAccordionState();
}

class _MoonAccordionState extends State<MoonAccordion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(splashFactory: NoSplash.splashFactory),
      child: ExpansionTile(
        expandedAlignment: Alignment.topCenter,
        onExpansionChanged: (value) => setState(() {
          _isExpanded = value;
        }),
        trailing: AnimatedRotation(
          turns: _isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOutCubic,
          child: widget.icon ?? const Icon(MoonIconsControls.chevron_down24),
        ),
        title: widget.title,
        children: widget.children,
      ),
    );
  }
}
