import 'package:example/src/storybook/common/constants.dart';
import 'package:example/src/storybook/common/typography_page_options.dart';
import 'package:example/src/storybook/common/widgets/page_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_design/moon_design.dart';

class TypographyPage extends StatelessWidget {
  static const path = '/typography';

  const TypographyPage({super.key});

  Widget _buildSectionHeader(
    BuildContext context,
    TypographyPageSection section,
  ) {
    final bool isHeader = section == TypographyPageSection.typography;
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
        if (section.bodyText.isNotEmpty)
          Text(
            section.bodyText,
            style: context.moonTypography!.body.text16,
          ),
      ],
    );
  }

  Widget _buildTypographyContainer(BuildContext context, MoonTextStyle style) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: context.moonColors!.gohan,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          MoonTextSize.values.length * 2 - 1,
          (int index) {
            final int derivedIndex = index ~/ 2;

            return index.isEven
                ? Text(
                    MoonTextSize.values[derivedIndex].name,
                    style: style == MoonTextStyle.body
                        ? getBodyTextStyle(
                            context,
                            MoonTextSize.values[derivedIndex],
                          )
                        : getHeadingTextStyle(
                            context,
                            MoonTextSize.values[derivedIndex],
                          ),
                  )
                : const SizedBox(height: 8.0);
          },
        ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          context,
                          TypographyPageSection.typography,
                        ),
                        const SizedBox(height: 48.0),
                        _buildSectionHeader(
                          context,
                          TypographyPageSection.body,
                        ),
                        _buildTypographyContainer(context, MoonTextStyle.body),
                        const SizedBox(height: 48.0),
                        _buildSectionHeader(
                          context,
                          TypographyPageSection.heading,
                        ),
                        _buildTypographyContainer(
                          context,
                          MoonTextStyle.heading,
                        ),
                        const Center(
                          child: PageFooter(),
                        ),
                      ],
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
