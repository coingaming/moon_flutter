import 'package:flutter/material.dart';
import 'package:moon_design/src/widgets/avatar/avatar_painter.dart';

class MoonAvatar extends StatelessWidget {
  const MoonAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red, strokeAlign: BorderSide.strokeAlignOutside),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      child: CustomPaint(
        willChange: true,
        painter: AvatarPainter(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.person,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6))),
            )
          ],
        ),
      ),
    );
  }
}
