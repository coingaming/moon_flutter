import 'dart:math';
import 'dart:ui';

import 'package:example/src/storybook/common/widgets/segment.dart';
import 'package:flutter/material.dart';
import 'package:moon_icons/moon_icons.dart';

class IconsStory extends StatelessWidget {
  static const path = '/icons';

  const IconsStory({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollBehavior scrollBehaviour = ScrollConfiguration.of(context).copyWith(
      scrollbars: false,
      overscroll: false,
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      },
    );

    Map<String, Map<String, IconData>> segments = {};
    final Map<String, Map<String, IconData>> lightSegments = {};
    final Map<String, Map<String, IconData>> regularSegments = {};

    for (final String key in iconsMap.keys) {
      // Extract the segment and type (like light or regular)
      final List<String> parts = key.split('_');
      final String segment = parts.first;
      final String type = parts.last;

      if (type == "light") {
        if (!lightSegments.containsKey(segment)) {
          lightSegments[segment] = {};
        }
        lightSegments[segment]![key] = iconsMap[key]!;
      } else if (type == "regular") {
        if (!regularSegments.containsKey(segment)) {
          regularSegments[segment] = {};
        }
        regularSegments[segment]![key] = iconsMap[key]!;
      }
    }

    final Map<String, Map<String, IconData>> combinedSegments = {};

    // Get all unique segment names
    final Set<String> allSegments = lightSegments.keys.toSet()..addAll(regularSegments.keys);

    for (final String segment in allSegments) {
      combinedSegments[segment] = {};

      // Get the list of keys from light and regular segments for this segment
      final List<String> lightKeys = lightSegments[segment]?.keys.toList() ?? [];
      final List<String> regularKeys = regularSegments[segment]?.keys.toList() ?? [];

      // Iterate in steps of 3 for trios
      final int maxLightIndex = (lightKeys.length / 3).ceil() * 3;
      final int maxRegularIndex = (regularKeys.length / 3).ceil() * 3;

      for (int i = 0; i < max(maxLightIndex, maxRegularIndex); i += 3) {
        // Add up to three light icons
        for (int j = i; j < min(i + 3, lightKeys.length); j++) {
          final String key = lightKeys[j];
          combinedSegments[segment]![key] = lightSegments[segment]![key]!;
        }
        // Add up to three regular icons
        for (int j = i; j < min(i + 3, regularKeys.length); j++) {
          final String key = regularKeys[j];
          combinedSegments[segment]![key] = regularSegments[segment]![key]!;
        }
      }
    }

    segments = combinedSegments;

    return CustomScrollView(
      scrollBehavior: scrollBehaviour,
      slivers: segments.values.map((e) => IconsSegment(segmentMap: e)).toList(),
    );
  }
}
