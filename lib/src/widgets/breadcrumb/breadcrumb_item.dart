import 'package:flutter/material.dart';

class BreadcrumbItem {
  /// The widget in the label slot of the tab.
  final Widget? label;

  /// The widget in the leading slot of the tab.
  final Widget? leading;

  /// The semantic label for the segment.
  final String? semanticLabel;

  /// The callback that is called when the item is tapped or pressed.
  final VoidCallback? onPressed;

  const BreadcrumbItem({
    this.label,
    this.leading,
    this.semanticLabel,
    this.onPressed,
  });
}
