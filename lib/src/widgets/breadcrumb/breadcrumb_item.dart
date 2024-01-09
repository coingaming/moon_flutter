import 'package:flutter/material.dart';

class BreadcrumbItem {
  /// The widget in the label slot of the BreadcrumbItem.
  final Widget? label;

  /// The widget in the leading slot of the BreadcrumbItem.
  final Widget? leading;

  /// The semantic label for the BreadcrumbItem.
  final String? semanticLabel;

  /// The callback that is called when the BreadcrumbItem is tapped or pressed.
  final VoidCallback? onPressed;

  const BreadcrumbItem({
    this.label,
    this.leading,
    this.semanticLabel,
    this.onPressed,
  });
}
