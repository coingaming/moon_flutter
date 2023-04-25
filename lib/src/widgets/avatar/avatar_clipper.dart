import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/rendering.dart';

import 'package:moon_design/src/widgets/avatar/avatar.dart';

class AvatarClipper extends CustomClipper<Path> {
  final bool showBadge;
  final BorderRadius borderRadius;
  final double height;
  final double width;
  final double badgeMarginValue;
  final double badgeSize;
  final MoonBadgeAlignment badgeAlignment;
  final TextDirection textDirection;

  AvatarClipper({
    required this.showBadge,
    required this.borderRadius,
    required this.height,
    required this.width,
    required this.badgeMarginValue,
    required this.badgeSize,
    required this.badgeAlignment,
    required this.textDirection,
  });

  Path _getBadgePath() {
    final badgeRadius = badgeSize / 2;

    if (textDirection == TextDirection.rtl) {
      switch (badgeAlignment) {
        case MoonBadgeAlignment.topLeft:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(width - badgeRadius, 0 + badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
        case MoonBadgeAlignment.topRight:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(0 + badgeRadius, 0 + badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
        case MoonBadgeAlignment.bottomLeft:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(width - badgeRadius, width - badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
        case MoonBadgeAlignment.bottomRight:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(0 + badgeRadius, width - badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
        default:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(width - badgeRadius, width - badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
      }
    } else {
      switch (badgeAlignment) {
        case MoonBadgeAlignment.topLeft:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(0 + badgeRadius, 0 + badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
        case MoonBadgeAlignment.topRight:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(width - badgeRadius, 0 + badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
        case MoonBadgeAlignment.bottomLeft:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(0 + badgeRadius, height - badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
        case MoonBadgeAlignment.bottomRight:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(width - badgeRadius, height - badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
        default:
          return Path()
            ..addOval(
              Rect.fromCircle(
                center: Offset(width - badgeRadius, width - badgeRadius),
                radius: badgeRadius + badgeMarginValue,
              ),
            );
      }
    }
  }

  @override
  Path getClip(Size size) {
    final pathWithBadge = Path.combine(
      PathOperation.difference,
      // Avatar shape properties
      Path()
        ..addRRect(
          RRect.fromLTRBAndCorners(
            0,
            0,
            width,
            height,
            topLeft: SmoothRadius(cornerRadius: borderRadius.topLeft.x, cornerSmoothing: 1),
            topRight: SmoothRadius(cornerRadius: borderRadius.topRight.x, cornerSmoothing: 1),
            bottomLeft: SmoothRadius(cornerRadius: borderRadius.bottomLeft.x, cornerSmoothing: 1),
            bottomRight: SmoothRadius(cornerRadius: borderRadius.bottomRight.x, cornerSmoothing: 1),
          ),
        ),
      // Badge shape properties
      _getBadgePath(),
    );

    final pathWithoutBadge = Path()
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width,
          height,
          topLeft: SmoothRadius(cornerRadius: borderRadius.topLeft.x, cornerSmoothing: 1),
          topRight: SmoothRadius(cornerRadius: borderRadius.topRight.x, cornerSmoothing: 1),
          bottomLeft: SmoothRadius(cornerRadius: borderRadius.bottomLeft.x, cornerSmoothing: 1),
          bottomRight: SmoothRadius(cornerRadius: borderRadius.bottomRight.x, cornerSmoothing: 1),
        ),
      );

    return showBadge ? pathWithBadge : pathWithoutBadge;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
