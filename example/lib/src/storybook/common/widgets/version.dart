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
  String? _version = "";

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/moon-logo-short.svg", width: 24.0, height: 24.0),
            const SizedBox(width: 8.0),
            Text(
              "Moon Design",
              style: MoonTypography.textStyles.text.text16,
            ),
            const SizedBox(width: 6.0),
            Text("v$_version", style: MoonTypography.textStyles.heading.text16),
          ],
        ),
      ),
    );
  }
}
