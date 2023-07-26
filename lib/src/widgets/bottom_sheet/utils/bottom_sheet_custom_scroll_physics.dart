import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomModalScrollPhysics extends ScrollPhysics {
  final AnimationController controller;

  /// Creates scroll physics that prevent the scroll offset from exceeding the top bound of the modal.
  /// Enables user to drag bottomsheet up and down with scrollable content.
  const CustomModalScrollPhysics({super.parent, required this.controller});

  @override
  CustomModalScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomModalScrollPhysics(parent: buildParent(ancestor), controller: controller);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('$runtimeType.applyBoundaryConditions() was called redundantly.'),
          ErrorDescription(
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.',
          ),
          DiagnosticsProperty<ScrollPhysics>(
            'The physics object in question was',
            this,
            style: DiagnosticsTreeStyle.errorProperty,
          ),
          DiagnosticsProperty<ScrollMetrics>(
            'The position object in question was',
            position,
            style: DiagnosticsTreeStyle.errorProperty,
          ),
        ]);
      }
      return true;
    }());

    if (value < position.pixels && position.pixels <= position.minScrollExtent) {
      // Underscroll while dragging down.
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels && position.pixels < value) {
      // Overscroll.
      return value - position.pixels;
    }
    if (value < position.minScrollExtent && position.minScrollExtent < position.pixels) {
      // Hit top edge.
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent && position.maxScrollExtent < value) {
      // Hit bottom edge.
      return value - position.maxScrollExtent;
    }
    if (value > position.pixels && position.pixels == 0 && controller.value < 1) {
      // Underscroll while dragging up.
      return value - position.pixels;
    }

    return 0.0;
  }
}
