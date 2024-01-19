import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class BreadcrumbStory extends StatefulWidget {
  const BreadcrumbStory({super.key});

  @override
  State<BreadcrumbStory> createState() => _BreadcrumbStoryState();
}

class _BreadcrumbStoryState extends State<BreadcrumbStory> {
  bool _showDropdown = false;
  Color? _dropdownIconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // The default MoonBreadcrumb. 
        // Expands horizontally to the full path when the indicated show more item is tapped.
        Column(
          children: [
            MoonBreadcrumb(
              items: List.generate(
                6,
                (int index) {
                  return MoonBreadcrumbItem(
                    onTap: () {},
                    label: Text('Page $index'),
                  );
                },
              ),
            ),
            // Provides an explicit method to restore the expanded breadcrumb path 
            // to its collapsed state, enabling external control.
            // By default, the state is automatically restored during rebuild.
            MoonButton(
              onTap: () => setState(() => {}),
              label: const Text('Reset'),
            ),
          ],
        ),

        // MoonBreadcrumb with the MoonDropdown and a custom showMoreWidget.
        MoonBreadcrumb(
          divider: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? MoonIcons.controls_chevron_right_small_16_light
                : MoonIcons.controls_chevron_left_small_16_light,
          ),
          showMoreWidget: MoonDropdown(
            show: _showDropdown,
            onTapOutside: () => setState(() {
              _showDropdown = false;
              _dropdownIconColor = context.moonColors!.iconSecondary;
            }),
            content: Column(
              children: List.generate(
                3,
                (int index) => MoonMenuItem(
                  onTap: () {},
                  label: Text('Page ${index + 1}'),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: MouseRegion(
                onHover: (PointerHoverEvent _) {
                  setState(() => _dropdownIconColor = context.moonColors!.iconPrimary);
                },
                onExit: (PointerExitEvent _) {
                  if (!_showDropdown) setState(() => _dropdownIconColor = context.moonColors!.iconSecondary);
                },
                child: MoonButton.icon(
                  buttonSize: MoonButtonSize.xs,
                  hoverEffectColor: Colors.transparent,
                  iconColor: _dropdownIconColor ?? context.moonColors!.iconSecondary,
                  onTap: () => setState(() => _showDropdown = !_showDropdown),
                  icon: const Icon(MoonIcons.generic_burger_regular_16_light),
                ),
              ),
            ),
          ),
          items: List.generate(
            6,
            (int index) {
              return MoonBreadcrumbItem(
                onTap: () {},
                label: Text('Page $index'),
              );
            },
          ),
        ),
      ],
    );
  }
}