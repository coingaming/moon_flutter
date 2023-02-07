import 'package:flutter/material.dart';

import 'package:moon_design/moon_design.dart';

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

    final fileContent = await DefaultAssetBundle.of(context).loadString("../pubspec.lock");
    final entry = fileContent.split("moon_design:")[1].split("version:")[1];
    final version = RegExp('"(.*?)"').firstMatch(entry)?.group(0)?.replaceAll('"', "");

    setState(() {
      _version = version;
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
            const MoonBrandIcon(),
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
