import 'package:flutter/material.dart';

class MoonBreadcrumbItem {
  /// The gap between the [leading], [label] and [trailing] widgets of the
  /// breadcrumb item.
  final double? gap;

  /// The semantic label for the breadcrumb item.
  final String? semanticLabel;

  /// The callback that is called when the breadcrumb item is tapped or pressed.
  /// If null, the breadcrumb item is disabled.
  ///
  /// For [MoonBreadcrumb.showMoreWidget], when [onTap] is null, default
  /// behavior is to display all collapsed breadcrumb items.
  final VoidCallback? onTap;

  /// The widget to display before the [label] widget of the breadcrumb item.
  final Widget? leading;

  /// The primary content of the breadcrumb item.
  final Widget label;

  /// The widget to display after the [label] widget of the breadcrumb item.
  final Widget? trailing;

  /// Creates a Moon Design breadcrumb item.
  const MoonBreadcrumbItem({
    this.gap,
    this.semanticLabel,
    this.onTap,
    this.leading,
    required this.label,
    this.trailing,
  });
}
