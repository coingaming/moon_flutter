import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/colors_page_options.dart';
import 'package:example/src/storybook/common/constants.dart';
import 'package:example/src/storybook/common/widgets/page_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_design/moon_design.dart';

typedef ItemsPerRow = int Function(int);

class ColorsPage extends StatelessWidget {
  static const path = '/colors';

  const ColorsPage({super.key});

  static const int _defaultColorContainersInRow = 3;
  static const double _colorContainerSizeValue = 128.0;
  static const double _colorContainerGap = 24.0;

  Widget _buildMainColorsSection(BuildContext context) {
    return _buildColorsSection(
      context: context,
      rows: 6,
      itemsPerRow: (int rowIndex) => switch (rowIndex) {
        1 => 1,
        5 => _defaultColorContainersInRow,
        _ => 2,
      },
      section: ColorsPageSection.mainColors,
      colors: mainColorsList,
    );
  }

  Widget _buildSupportiveColorsSection(BuildContext context) {
    return _buildColorsSection(
      context: context,
      rows: 9,
      itemsPerRow: (int _) => _defaultColorContainersInRow,
      section: ColorsPageSection.supportiveColors,
      colors: supportiveColorsList,
    );
  }

  double _getFooterWidth(BuildContext context) {
    return MediaQuery.of(context).size.width < storybookAutoLayoutThreshold
        ? mediumScreenWidth
        : _colorContainerSizeValue * _defaultColorContainersInRow +
            (_defaultColorContainersInRow - 1) * _colorContainerGap;
  }

  int _getColorIndex(int rowIndex, int childIndex, ItemsPerRow getItemsPerRow) {
    int colorIndex = 0;

    for (int i = 0; i < rowIndex; i++) {
      colorIndex += getItemsPerRow(i);
    }

    return colorIndex + childIndex;
  }

  Widget _highlightedBodyText(BuildContext context, String text) {
    if (text.isEmpty) return const Text('');

    final TextStyle textStyle = context.moonTypography!.body.text16;

    final String pattern =
        MoonColor.values.map((color) => color.name).toList().join('|');
    final regex = RegExp(pattern, caseSensitive: false);

    final List<InlineSpan> spans = <InlineSpan>[];
    int start = 0;

    for (final match in regex.allMatches(text)) {
      if (start == match.start) continue;

      spans.addAll([
        TextSpan(
          text: text.substring(start, match.start),
          style: textStyle,
        ),
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
              color: context.moonColors!.gohan,
              border: Border.all(
                color: context.moonColors!.goten,
                width: 0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              match.group(0)!,
              style: textStyle,
            ),
          ),
        ),
      ]);

      start = match.end;
    }

    spans.add(
      TextSpan(
        text: text.substring(start),
        style: textStyle,
      ),
    );

    return Text.rich(
      TextSpan(
        style: textStyle,
        children: spans,
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, ColorsPageSection section) {
    final bool isHeader = section == ColorsPageSection.header;
    final bool showLogo =
        MediaQuery.of(context).size.width < storybookAutoLayoutThreshold;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isHeader && showLogo)
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 24.0),
            child: SvgPicture.asset(
              'assets/svg/moon-logo-long.svg',
              height: 16.0,
            ),
          ),
        Text(
          section.titleText,
          style: isHeader
              ? context.moonTypography!.heading.text40
              : context.moonTypography!.heading.text24,
        ),
        const SizedBox(height: 24),
        _highlightedBodyText(context, section.bodyText),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildColorsSection({
    required BuildContext context,
    required int rows,
    required ItemsPerRow itemsPerRow,
    required ColorsPageSection section,
    required List<MoonColor> colors,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: rows * 2 - 1,
      itemBuilder: (BuildContext context, int rowIndex) {
        final int derivedRowIndex = rowIndex ~/ 2;
        final int itemsInRow = itemsPerRow(derivedRowIndex);

        return rowIndex.isEven
            ? Row(
                children: List.generate(
                  _defaultColorContainersInRow * 2 - 1,
                  (int rowItemIndex) {
                    if (rowItemIndex.isEven) {
                      final int derivedItemIndex = rowItemIndex ~/ 2;

                      if (derivedItemIndex < itemsInRow) {
                        final int colorIndex = _getColorIndex(
                          derivedRowIndex,
                          derivedItemIndex,
                          itemsPerRow,
                        );

                        final MoonColor moonColor =
                            colors[colorIndex % colors.length];

                        return _buildColorContainer(context, moonColor);
                      } else {
                        return const Flexible(
                          child: SizedBox(
                            height: _colorContainerSizeValue,
                            width: _colorContainerSizeValue,
                          ),
                        );
                      }
                    } else {
                      return const SizedBox(width: _colorContainerGap);
                    }
                  },
                ),
              )
            : const SizedBox(height: _colorContainerGap);
      },
    );
  }

  Widget _buildColorContainer(BuildContext context, MoonColor moonColor) {
    final double colorContainerWidth =
        MediaQuery.of(context).size.width < storybookAutoLayoutThreshold
            ? double.infinity
            : _colorContainerSizeValue;

    return Flexible(
      child: Column(
        children: [
          Container(
            height: _colorContainerSizeValue,
            width: colorContainerWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: context.moonColors!.beerus),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: getColor(context, moonColor),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(moonColor.name),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool showLogo =
        MediaQuery.of(context).size.width < storybookAutoLayoutThreshold;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: showLogo ? 40.0 : 80,
          left: 24,
          right: 24,
          bottom: 16.0,
        ),
        child: SelectionArea(
          child: Center(
            child: SizedBox(
              width: largeScreenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: mediumScreenWidth,
                    ),
                    child: Column(
                      children: [
                        _buildSectionHeader(
                          context,
                          ColorsPageSection.header,
                        ),
                        const SizedBox(height: 24.0),
                        _buildSectionHeader(
                          context,
                          ColorsPageSection.mainColors,
                        ),
                        _buildMainColorsSection(context),
                        const SizedBox(height: 48.0),
                        _buildSectionHeader(
                          context,
                          ColorsPageSection.supportiveColors,
                        ),
                        _buildSupportiveColorsSection(context),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: _getFooterWidth(context),
                    ),
                    child: const Center(
                      child: PageFooter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
