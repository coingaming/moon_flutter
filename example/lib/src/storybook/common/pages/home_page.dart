import 'dart:math';

import 'package:example/src/storybook/common/component_options.dart';
import 'package:example/src/storybook/common/constants.dart';
import 'package:example/src/storybook/common/home_page_options.dart';
import 'package:example/src/storybook/common/methods/navigation.dart';
import 'package:example/src/storybook/common/social_media_options.dart';
import 'package:example/src/storybook/common/widgets/page_footer.dart';
import 'package:example/src/storybook/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_design/moon_design.dart';

class HomePage extends StatelessWidget {
  static const path = '/';

  const HomePage({super.key});

  double _getCardWidth(BuildContext context, double gap, double layoutWidth) {
    const double cardMaxWidth = 448.0;

    final int itemsInRow = switch (MediaQuery.of(context).size.width) {
      < mediumScreenWidth => 1,
      >= mediumScreenWidth && < largeScreenWidth => 2,
      _ => 3,
    };

    final double effectiveLayoutWidth =
        itemsInRow == 3 ? layoutWidth * 0.85 : layoutWidth;

    final double totalGap = gap * (itemsInRow - 1);

    return min((effectiveLayoutWidth - totalGap) / itemsInRow, cardMaxWidth);
  }

  Widget _buildHeaderSection(BuildContext context, bool showLogo) {
    final MoonTypography typography = context.moonTypography!;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: mediumScreenWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLogo)
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 24.0),
              child: SvgPicture.asset(
                'assets/svg/moon-logo-long.svg',
                height: 16.0,
              ),
            ),
          Text(
            HomePageContentType.headerTitle.text,
            style: typography.heading.text64,
          ),
          const SizedBox(height: 24.0),
          Text(
            HomePageContentType.headerSubtitle.text,
            style: typography.heading.text24,
          ),
          const SizedBox(height: 48.0),
          _buildHeaderButtons(context),
          const SizedBox(height: 72.0),
          Text(
            HomePageContentType.bodyTitle.text,
            style: typography.heading.text40,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButtons(BuildContext context) {
    const double buttonGap = 12.0;

    return MediaQuery.of(context).size.width < smallScreenWidth
        ? Column(
            children: [
              _buildButton(context, SocialMedia.gitHub),
              const SizedBox(height: buttonGap),
              _buildButton(context, SocialMedia.figma),
            ],
          )
        : Row(
            children: [
              Flexible(child: _buildButton(context, SocialMedia.gitHub)),
              const SizedBox(width: buttonGap),
              Flexible(child: _buildButton(context, SocialMedia.figma)),
            ],
          );
  }

  Widget _buildButton(BuildContext context, SocialMedia socialMedia) {
    final bool isGitHub = socialMedia == SocialMedia.gitHub;

    return MoonButton(
      width: double.infinity,
      backgroundColor:
          isGitHub ? context.moonColors!.piccolo : context.moonColors!.krillin,
      onTap: () => launchURL(socialMedia.url),
      leading: SvgPicture.asset(
        socialMedia.buttonIconPath,
        width: 20.0,
      ),
      label: Flexible(
        child: SizedBox(
          width: 56,
          child: Text(
            socialMedia.name,
            style:
                isGitHub ? TextStyle(color: context.moonColors!.goten) : null,
          ),
        ),
      ),
    );
  }

  Widget _buildCards(BuildContext context, double layoutWidth) {
    const double cardGap = 24.0;
    const double cardHeight = 346.0;
    const double cardImageHeight = 208.0;

    final BorderRadiusGeometry borderRadius = BorderRadius.circular(16);

    final double cardWidth = _getCardWidth(context, cardGap, layoutWidth);

    final bool isExtraSmallScreen =
        MediaQuery.of(context).size.width < extraSmallScreenWidth;

    return Wrap(
      spacing: cardGap,
      runSpacing: cardGap,
      alignment: layoutWidth < mediumScreenWidth
          ? WrapAlignment.center
          : WrapAlignment.start,
      children: List.generate(
        Component.values.length,
        (int index) {
          final Component component = Component.values[index];

          return MoonBaseControl(
            borderRadius: borderRadius,
            onTap: () => router.go(component.urlPath),
            builder: (BuildContext context, _, bool isHovered, __, ___) {
              return Container(
                height: cardHeight,
                width: cardWidth,
                decoration: BoxDecoration(
                  color: context.moonColors!.goten,
                  borderRadius: borderRadius,
                  border: Border.all(color: context.moonColors!.beerus),
                  boxShadow: isHovered
                      ? [
                          BoxShadow(
                            color: context.moonColors!.trunks.withOpacity(.4),
                            blurRadius: 6.0,
                            spreadRadius: -3.0,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: cardImageHeight,
                      width: cardWidth,
                      margin: const EdgeInsets.all(8.0),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(borderRadius: borderRadius),
                      child: Image.asset(
                        colorBlendMode: BlendMode.saturation,
                        color: isHovered ? Colors.transparent : Colors.grey,
                        component.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 24.0,
                        right: 24.0,
                        top: isExtraSmallScreen ? 8.0 : 16.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            component.name,
                            overflow: TextOverflow.ellipsis,
                            style: context.moonTypography!.heading.text20,
                          ),
                          SizedBox(height: isExtraSmallScreen ? 4.0 : 8.0),
                          Text(
                            component.description,
                            maxLines: isExtraSmallScreen ? 3 : 2,
                            overflow: TextOverflow.ellipsis,
                            style: context.moonTypography!.heading.text14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double layoutWidth = MediaQuery.of(context).size.width;

    final bool showLogo = layoutWidth < storybookAutoLayoutThreshold;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: showLogo ? 40.0 : 80,
          left: 24,
          right: 24,
          bottom: 16.0,
        ),
        child: Center(
          child: SizedBox(
            width: largeScreenWidth,
            child: Column(
              crossAxisAlignment: layoutWidth > mediumScreenWidth
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                _buildHeaderSection(context, showLogo),
                const SizedBox(height: 48.0),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Column(
                      children: [
                        _buildCards(context, constraints.maxWidth),
                        const PageFooter(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
