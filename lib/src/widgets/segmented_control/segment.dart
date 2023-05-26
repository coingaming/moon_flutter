import 'package:flutter/material.dart';

import 'package:moon_design/src/widgets/segmented_control/segment_style.dart';

class Segment {
  /// {@macro flutter.widgets.Focus.autofocus}.
  final bool autoFocus;

  /// Whether this segment should be focusable.
  final bool isFocusable;

  /// Whether this segment should show a focus effect.
  final bool showFocusEffect;

  /// {@macro flutter.widgets.Focus.focusNode}.
  final FocusNode? focusNode;

  /// The styling options for the segment.
  final SegmentStyle? segmentStyle;

  /// The semantic label for the segment.
  final String? semanticLabel;

  /// Callback that returns boolean value if segment is currently selected or not.
  final ValueChanged<bool>? isSelected;

  /// The widget in the leading slot of the segment.
  final Widget? leading;

  /// The widget in the label slot of the segment.
  final Widget? label;

  /// The widget in the trailing slot of the segment.
  final Widget? trailing;

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
