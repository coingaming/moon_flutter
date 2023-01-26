import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class MoonFilledButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget child;

  const MoonFilledButton({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MoonControlWrapper(
      onTap: () {},
      builder: (context, isEnabled, isHovered, isFocused, isPressed) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          height: 40,
          width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: !isEnabled
                ? Colors.red
                : isHovered
                    ? Colors.blue
                    : Colors.blue.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: isFocused ? MoonColors.light.jiren : Colors.transparent,
                spreadRadius: 4,
              )
            ],
          ),
          child: child,
        );
      },
    );
  }
}
