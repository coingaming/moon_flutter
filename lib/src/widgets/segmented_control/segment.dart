import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/segmented_control/segment_style.dart';

class Segment {
  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autoFocus;

  /// Whether the segment is focusable.
  final bool isFocusable;

  /// Whether to show a focus outline effect when the segment is focused.
  final bool showFocusEffect;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The styling options for the segment.
  final SegmentStyle? segmentStyle;

  /// The semantic label for the segment.
  final String? semanticLabel;

  /// The callback that returns the current selection status of the segment as a boolean value.
  final ValueChanged<bool>? isSelected;

  /// The widget to display before the [label] widget of the segment.
  final Widget? leading;

  /// The primary content of the segment widget.
  final Widget? label;

  /// The widget to display after the [label] widget of the segment.
  final Widget? trailing;

  /// Creates a Moon Design segment.
  const Segment({
    this.autoFocus = false,
    this.isFocusable = true,
    this.showFocusEffect = true,
    this.focusNode,
    this.segmentStyle,
    this.semanticLabel,
    this.isSelected,
    this.leading,
    this.label,
    this.trailing,
  });
}
