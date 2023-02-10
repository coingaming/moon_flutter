import 'dart:math';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/rendering.dart';

import 'package:moon_design/src/widgets/avatar/avatar.dart';

class AvatarClipper extends CustomClipper<Path> {
  final bool showBadge;
  final double width;
  final double height;
  final double badgeSize;
  final double badgeMarginValue;
  final double borderRadiusValue;
  final MoonBadgeAlignment badgeAlignment;

  AvatarClipper({
    required this.showBadge,
    required this.width,
    required this.height,
    required this.badgeSize,
    required this.badgeMarginValue,
    required this.borderRadiusValue,
    required this.badgeAlignment,
  });

  Path _getBadgePath() {
    final badgeRadius = badgeSize / 2;

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
              center: Offset(0 + badgeRadius, width - badgeRadius),
              radius: badgeRadius + badgeMarginValue,
            ),
          );
      case MoonBadgeAlignment.bottomRight:
        return Path()
          ..addOval(
            Rect.fromCircle(
              center: Offset(width - badgeRadius, width - badgeRadius),
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

  @override
  Path getClip(Size size) {
    final smallestDimension = min(width, height);

    final pathWithBadge = Path.combine(
      PathOperation.difference,
      // Avatar shape properties
      Path()
        ..addRRect(
          RRect.fromLTRBR(
            0,
            0,
            width,
            height,
            SmoothRadius(
              cornerRadius: min(borderRadiusValue, smallestDimension / 2),
              cornerSmoothing: 1,
            ),
          ),
        ),
      // Badge shape properties
      _getBadgePath(),
    );

    final pathWithoutBadge = Path()
      ..addRRect(
        RRect.fromLTRBR(
          0,
          0,
          width,
          height,
          SmoothRadius(
            cornerRadius: min(borderRadiusValue, smallestDimension / 2),
            cornerSmoothing: 1,
          ),
        ),
      );

    return showBadge ? pathWithBadge : pathWithoutBadge;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
