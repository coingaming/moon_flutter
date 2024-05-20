import 'dart:ui';

import 'package:example/src/storybook/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moon_design/moon_design.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MoonVersionWidget extends StatefulWidget {
  const MoonVersionWidget({super.key});

  @override
  State<MoonVersionWidget> createState() => _MoonVersionWidgetState();
}

class _MoonVersionWidgetState extends State<MoonVersionWidget> {
  bool isLargeScreen =
      MediaQueryData.fromView(PlatformDispatcher.instance.implicitView!)
              .size
              .width >
          storybookAutoLayoutThreshold;

  String? _version = "";

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (mounted) setState(() => _version = packageInfo.version);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: isLargeScreen
                ? MainAxisAlignment.center
                : MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                "assets/svg/moon-logo-short.svg",
                width: 24.0,
                height: 24.0,
              ),
              if (isLargeScreen) ...[
                const SizedBox(width: 8.0),
                Text(
                  "Moon Design",
                  style: MoonTypography.typography.heading.text14,
                ),
              ],
              const SizedBox(width: 6.0),
              Text(
                "v$_version",
                style: MoonTypography.typography.heading.text14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
