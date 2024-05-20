import 'package:example/src/storybook/common/methods/navigation.dart';
import 'package:example/src/storybook/common/social_media_options.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_design/moon_design.dart';

class PageFooter extends StatelessWidget {
  const PageFooter({super.key});

  Widget _buildFooterSocialMediaButtons(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(
        SocialMedia.values.length * 2 - 1,
        (int index) {
          final int derivedIndex = index ~/ 2;

          return index.isEven
              ? MoonTextButton(
                  buttonSize: MoonButtonSize.sm,
                  onTap: () => launchURL(SocialMedia.values[derivedIndex].url),
                  label: Text(
                    SocialMedia.values[derivedIndex].name,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '•',
                    style: TextStyle(color: context.moonColors!.trunks),
                  ),
                );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: 'With the help of ',
            style: context.moonTypography!.body.text14,
            children: [
              TextSpan(
                text: 'Yolo Group',
                style: context.moonTypography!.heading.text14,
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launchURL(yoloUrl),
              ),
              const WidgetSpan(
                child: SizedBox(width: 4),
              ),
              WidgetSpan(
                child: SvgPicture.asset(
                  'assets/svg/heart.svg',
                  width: 20.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        _buildFooterSocialMediaButtons(context),
      ],
    );
  }
}
