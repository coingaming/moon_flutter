import 'package:flutter/material.dart';

class MoonBreadcrumbItem {
  /// The gap between the breadcrumb item's [leading], [label] and [trailing] widgets.
  final double? gap;

  /// The semantic label of the breadcrumb's item.
  final String? semanticLabel;

  /// Called when the breadcrumb's item is tapped or pressed.
  /// If null, the breadcrumb's item is disabled.
  final VoidCallback? onTap;

  /// The widget placed before the breadcrumb item's [label] widget.
  final Widget? leading;

  /// The main content of the breadcrumb's item.
  final Widget label;

  /// The widget placed after the breadcrumb item's [label] widget.
  final Widget? trailing;

  const MoonBreadcrumbItem({
    this.gap,
    this.semanticLabel,
    this.onTap,
    this.leading,
    required this.label,
    this.trailing,
  });
}
