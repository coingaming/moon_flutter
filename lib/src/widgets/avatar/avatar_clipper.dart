import 'package:flutter/rendering.dart';

import 'package:moon_design/src/utils/squircle/squircle_radius.dart';
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
    final double badgeRadius = badgeSize / 2;

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
    final Path pathWithBadge = Path.combine(
      PathOperation.difference,
      // Avatar shape properties
      Path()
        ..addRRect(
          RRect.fromLTRBAndCorners(
            0,
            0,
            width,
            height,
            topLeft: MoonSquircleRadius(cornerRadius: borderRadius.topLeft.x),
            topRight: MoonSquircleRadius(cornerRadius: borderRadius.topRight.x),
            bottomLeft: MoonSquircleRadius(cornerRadius: borderRadius.bottomLeft.x),
            bottomRight: MoonSquircleRadius(cornerRadius: borderRadius.bottomRight.x),
          ),
        ),

      _getBadgePath(), // Badge shape properties.
    );

    final Path pathWithoutBadge = Path()
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width,
          height,
          topLeft: MoonSquircleRadius(cornerRadius: borderRadius.topLeft.x),
          topRight: MoonSquircleRadius(cornerRadius: borderRadius.topRight.x),
          bottomLeft: MoonSquircleRadius(cornerRadius: borderRadius.bottomLeft.x),
          bottomRight: MoonSquircleRadius(cornerRadius: borderRadius.bottomRight.x),
        ),
      );

    return showBadge ? pathWithBadge : pathWithoutBadge;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
