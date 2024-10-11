import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/tab_bar/pill_tab_style.dart';

class MoonPillTab {
  /// Whether the tab is disabled.
  final bool disabled;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autoFocus;

  /// Whether the tab is focusable.
  final bool isFocusable;

  /// Whether to show a focus outline effect when the tab is focused.
  final bool showFocusEffect;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The styling options for the tab.
  final MoonPillTabStyle? tabStyle;

  /// The semantic label for the tab.
  final String? semanticLabel;

  /// The callback that returns the current selection status of the tab as a
  /// boolean value.
  final ValueChanged<bool>? isSelected;

  /// The widget to display before the [label] widget of the tab.
  final Widget? leading;

  /// The primary content of the tab widget.
  final Widget? label;

  /// The widget to display after the [label] widget of the tab.
  final Widget? trailing;

  /// Creates a Moon Design pill tab.
  const MoonPillTab({
    this.disabled = false,
    this.autoFocus = false,
    this.isFocusable = true,
    this.showFocusEffect = true,
    this.focusNode,
    this.tabStyle,
    this.semanticLabel,
    this.isSelected,
    this.leading,
    this.label,
    this.trailing,
  });
}
