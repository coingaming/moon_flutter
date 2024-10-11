import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The base class for the Moon Design progress indicators.
///
/// This class defines the common properties and behavior for Moon Design
/// progress indicators. It can not be instantiated directly.
/// Use [MoonLinearProgressIndicator] for a linear progress indicator and
/// [MoonCircularProgressIndicator] for a circular progress indicator.
abstract class MoonBaseProgressIndicator extends StatefulWidget {
  /// The progress indicator's color as an animated value.
  final Animation<Color?>? valueColor;

  /// The background color of the progress indicator.
  ///
  /// Subclasses must override this method to define the visual representation
  /// of the progress indicator. See the subclass documentation for details.
  final Color backgroundColor;

  /// The color of the progress indicator.
  final Color color;

  /// The progress value of the progress indicator.
  ///
  /// A value of 0.0 indicates no progress, 1.0 indicates complete progress, and
  /// values in between represent the percentage of progress completed.
  /// The value will be clamped to be in the range 0.0-1.0.
  ///
  /// If `value` is null, this progress indicator is indeterminate, meaning it
  /// displays a predetermined animation that does not reflect actual progress.
  final double? value;

  /// The [SemanticsProperties.label] for the progress indicator.
  ///
  /// Determines the text that screen readers will read out to describe the
  /// purpose of this progress indicator.
  final String? semanticsLabel;

  /// The [SemanticsProperties.value] for the progress indicator.
  ///
  /// Used in conjunction with the [semanticsLabel] to provide additional
  /// context for screen readers to understand the progress indicator's current
  /// state.
  ///
  /// Primarily intended for use with determinate progress indicators, which
  /// defaults to the [ProgressIndicator.value] expressed as a percentage, i.e.
  /// `0.1` will become '10%'.
  final String? semanticsValue;

  /// Creates a Moon Design progress indicator.
  ///
  /// The [value] argument determines whether the progress indicator is
  /// determinate or indeterminate:
  ///
  /// * If [value] is null, the progress indicator is indeterminate and will
  ///   display a predetermined animation that does not indicate how much
  ///   progress is being made.
  /// * If [value] is a non-null number between 0.0 and 1.0, the progress
  ///   indicator is determinate and will display the progress percentage as a
  ///   value between 0% and 100%.
  ///
  /// ## Accessibility
  ///
  /// The [semanticsLabel] can be used to identify the purpose of this progress
  /// bar for screen reading software.
  /// The [semanticsValue] property may be used for determinate progress
  /// indicators to announce how much progress has been made.
  const MoonBaseProgressIndicator({
    super.key,
    this.valueColor,
    required this.backgroundColor,
    required this.color,
    this.value,
    this.semanticsLabel,
    this.semanticsValue,
  });

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(
      PercentProperty(
        'value',
        value,
        showName: false,
        ifNull: '<indeterminate>',
      ),
    );
  }

  Widget buildSemanticsWrapper({
    required BuildContext context,
    required Widget child,
  }) {
    String? expandedSemanticsValue = semanticsValue;

    if (value != null) {
      expandedSemanticsValue ??= '${(value! * 100).round()}%';
    }

    return Semantics(
      label: semanticsLabel,
      value: expandedSemanticsValue,
      child: child,
    );
  }
}
