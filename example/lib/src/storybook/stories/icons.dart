import 'dart:math';
import 'dart:ui';

import 'package:example/src/storybook/common/widgets/segment.dart';
import 'package:flutter/material.dart';
import 'package:moon_icons/moon_icons.dart';

class IconsStory extends StatelessWidget {
  static const path = '/icons';

  const IconsStory({super.key});

  // Helper function to group keys in trios
  List<List<String>> _groupInTrios(List<String> keys) {
    final List<List<String>> trios = [];
    for (int i = 0; i < keys.length; i += 3) {
      trios.add(keys.sublist(i, min(i + 3, keys.length)));
    }
    return trios;
  }

  Iterable<Map<String, IconData>> _getSortedIcons(Map<String, IconData> iconsMap) {
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

      // Group the keys in trios
      final List<List<String>> lightTrios = _groupInTrios(lightKeys);
      final List<List<String>> regularTrios = _groupInTrios(regularKeys);

      // Maximum number of trios in either list
      final int maxTrios = max(lightTrios.length, regularTrios.length);

      for (int i = 0; i < maxTrios; i++) {
        // Add light trios if available
        if (i < lightTrios.length) {
          for (final String key in lightTrios[i]) {
            combinedSegments[segment]![key] = lightSegments[segment]![key]!;
          }
        }
        // Add regular trios if available
        if (i < regularTrios.length) {
          for (final String key in regularTrios[i]) {
            combinedSegments[segment]![key] = regularSegments[segment]![key]!;
          }
        }
      }
    }

    return combinedSegments.values;
  }

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

    final sortedIcons = _getSortedIcons(iconsMap);

    return CustomScrollView(
      scrollBehavior: scrollBehaviour,
      slivers: sortedIcons.map((e) => IconsSegment(segmentMap: e)).toList(),
    );
  }
}
