import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MoonAvatar(
      avatarSize: MoonAvatarSize.sm,
      showBadge: true,
      content: Text('MD'),
    );
  }
}