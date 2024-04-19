import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoonLogoWidget extends StatefulWidget {
  const MoonLogoWidget({super.key});

  @override
  State<MoonLogoWidget> createState() => _MoonLogoWidgetState();
}

class _MoonLogoWidgetState extends State<MoonLogoWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 36.0, right: 24.0, bottom: 8.0),
        child: Row(
          children: [
            SvgPicture.asset("assets/svg/moon-logo-long.svg", width: 24.0, height: 24.0),
          ],
        ),
      ),
    );
  }
}
