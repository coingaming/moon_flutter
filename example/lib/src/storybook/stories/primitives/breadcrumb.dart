import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class BreadcrumbStory extends StatefulWidget {
  static const path = '/primitives/breadcrumb';

  const BreadcrumbStory({super.key});

  @override
  State<BreadcrumbStory> createState() => _BreadcrumbStoryState();
}

class _BreadcrumbStoryState extends State<BreadcrumbStory> {
  bool _showDropdown = false;
  Color? _dropdownIconColor;

  @override
  Widget build(BuildContext context) {
    final itemColorKnob = context.knobs.nullable.options(
      label: "Item color",
      description: "MoonColors variants for MoonBreadcrumb item.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final itemColor = colorTable(context)[itemColorKnob ?? 40];

    final currentItemColorKnob = context.knobs.nullable.options(
      label: "Current item color",
      description: "MoonColors variants for MoonBreadcrumb current item.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final currentItemColor = colorTable(context)[currentItemColorKnob ?? 40];

    final hoverEffectColorKnob = context.knobs.nullable.options(
      label: "hoverEffectColor",
      description: "MoonColors variants for MoonBreadcrumb item on hover.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final hoverEffectColor = colorTable(context)[hoverEffectColorKnob ?? 40];

    final dividerColorKnob = context.knobs.nullable.options(
      label: "dividerColor",
      description: "MoonColors variants for MoonBreadcrumb divider.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final dividerColor = colorTable(context)[dividerColorKnob ?? 40];

    final itemCountKnob = context.knobs.nullable.sliderInt(
      label: "Item count",
      description: "Total count of items for MoonBreadcrumb.",
      enabled: false,
      initial: 7,
      max: 12,
    );

    final visibleItemCountKnob = context.knobs.nullable.sliderInt(
      label: "visibleItemCount",
      description: "Number of items to display for MoonBreadcrumb.",
      enabled: false,
      initial: 3,
      max: 12,
    );

    final gapKnob = context.knobs.nullable.sliderInt(
      label: "gap",
      description: "Gap between MoonBreadcrumb items.",
      enabled: false,
      initial: 8,
      max: 16,
    );

    final showLeadingKnob = context.knobs.boolean(
      label: "leading",
      description: "Show widget in MoonBreadcrumb item leading slot.",
    );

    final showTrailingKnob = context.knobs.boolean(
      label: "trailing",
      description: "Show widget in MoonBreadcrumb item trailing slot.",
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const TextDivider(
          text: "MoonBreadcrumb",
          paddingTop: 0,
        ),
        Column(
          children: [
            MoonBreadcrumb(
              visibleItemCount: visibleItemCountKnob ?? 3,
              gap: gapKnob?.toDouble(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              hoverEffectColor: hoverEffectColor,
              dividerColor: dividerColor,
              itemTextStyle: TextStyle(color: itemColor),
              currentItemTextStyle: TextStyle(color: currentItemColor),
              items: List.generate(
                itemCountKnob ?? 7,
                (int index) {
                  final bool isHomePage = index == 0;

                  return MoonBreadcrumbItem(
                    onTap: () => MoonToast.show(
                      context,
                      displayDuration: const Duration(seconds: 1),
                      label: Text(isHomePage ? 'Home Page' : 'Page $index'),
                    ),
                    leading:
                        showLeadingKnob && isHomePage ? const Icon(MoonIcons.generic_home_16_light, size: 16) : null,
                    label: Text(isHomePage ? 'Home' : 'Page $index'),
                    trailing:
                        showTrailingKnob && isHomePage ? const Icon(MoonIcons.generic_home_16_light, size: 16) : null,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            MoonButton(
              backgroundColor: context.moonColors!.piccolo,
              onTap: () => setState(() => {}),
              label: Text(
                'Reset',
                style: TextStyle(color: context.moonColors!.goten),
              ),
            ),
          ],
        ),
        const TextDivider(text: "Custom MoonBreadcrumb with MoonDropdown"),
        StatefulBuilder(
          builder: (context, setState) {
            return MoonBreadcrumb(
              visibleItemCount: visibleItemCountKnob ?? 3,
              gap: gapKnob?.toDouble(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              hoverEffectColor: hoverEffectColor,
              dividerColor: dividerColor,
              itemTextStyle: TextStyle(color: itemColor),
              currentItemTextStyle: TextStyle(color: currentItemColor),
              itemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
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
                    4,
                    (int index) => MoonMenuItem(
                      width: 120,
                      onTap: () => MoonToast.show(
                        context,
                        displayDuration: const Duration(seconds: 1),
                        label: Text('Page ${index + 1}'),
                      ),
                      label: Text('Page ${index + 1}'),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: gapKnob?.toDouble() ?? 8),
                  child: MouseRegion(
                    onHover: (PointerHoverEvent event) {
                      setState(() => _dropdownIconColor = hoverEffectColor ?? context.moonColors!.iconPrimary);
                    },
                    onExit: (PointerExitEvent event) {
                      if (!_showDropdown) {
                        setState(() => _dropdownIconColor = itemColor ?? context.moonColors!.iconSecondary);
                      }
                    },
                    child: MoonButton.icon(
                      buttonSize: MoonButtonSize.xs,
                      hoverEffectColor: Colors.transparent,
                      iconColor: _dropdownIconColor ?? context.moonColors!.iconSecondary,
                      icon: const Icon(MoonIcons.generic_burger_regular_16_light),
                      onTap: () => setState(() => _showDropdown = !_showDropdown),
                    ),
                  ),
                ),
              ),
              items: List.generate(
                itemCountKnob ?? 7,
                (int index) {
                  final bool isHomePage = index == 0;

                  return MoonBreadcrumbItem(
                    onTap: () => MoonToast.show(
                      context,
                      displayDuration: const Duration(seconds: 1),
                      label: Text(isHomePage ? 'Home Page' : 'Page $index'),
                    ),
                    leading: showLeadingKnob && isHomePage
                        ? const Icon(
                            MoonIcons.generic_home_16_light,
                            size: 16,
                          )
                        : null,
                    label: Text(isHomePage ? 'Home' : 'Page $index'),
                    trailing: showTrailingKnob && isHomePage
                        ? const Icon(
                            MoonIcons.generic_home_16_light,
                            size: 16,
                          )
                        : null,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
