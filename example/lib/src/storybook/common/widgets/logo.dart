import 'package:example/src/storybook/common/pages/home_page.dart';
import 'package:example/src/storybook/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_design/moon_design.dart';

class MoonLogoWidget extends StatefulWidget {
  const MoonLogoWidget({super.key});

  @override
  State<MoonLogoWidget> createState() => _MoonLogoWidgetState();
}

class _MoonLogoWidgetState extends State<MoonLogoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0, left: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: MoonButton(
          showScaleEffect: false,
          hoverEffectColor: Colors.transparent,
          onTap: () => router.go(HomePage.path),
          label: SvgPicture.asset(
            "assets/svg/moon-logo-long.svg",
            height: 16.0,
          ),
        ),
      ),
    );
  }
}
