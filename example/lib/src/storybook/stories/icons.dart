import 'dart:math';
import 'dart:ui';

import 'package:example/src/storybook/common/widgets/segment.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class IconsStory extends StatefulWidget {
  static const path = '/icons';

  const IconsStory({super.key});

  @override
  State<IconsStory> createState() => _IconsStoryState();
}

class _IconsStoryState extends State<IconsStory> {
  final TextEditingController _searchController = TextEditingController();

  Map<String, IconData> _filteredIcons = {};

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

  void _performSearch() {
    setState(() {
      _filteredIcons = Map.fromEntries(
        iconsMap.entries
            .where((entry) => entry.key.contains(_searchController.text.toLowerCase()))
            .map((entry) => MapEntry(entry.key, entry.value)),
      );
    });
  }

  void _handleClear() {
    setState(() {
      _searchController.clear();
      _performSearch();
    });
  }

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_performSearch);

    // Perform search once on init to show all icons
    _performSearch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sortedIcons = _getSortedIcons(_filteredIcons);

    final ScrollBehavior scrollBehaviour = ScrollConfiguration.of(context).copyWith(
      scrollbars: false,
      overscroll: false,
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.moonColors?.goku,
        title: Theme(
          data: Theme.of(context),
          child: MoonTextInput(
            controller: _searchController,
            hintText: "Search icons",
            leading: const Icon(
              MoonIcons.generic_search_24_light,
              size: 24,
            ),
            trailing: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _handleClear,
                child: const Icon(
                  MoonIcons.controls_close_small_24_light,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        scrollBehavior: scrollBehaviour,
        slivers: sortedIcons.map((e) => IconsSegment(segmentMap: e)).toList(),
      ),
    );
  }
}
