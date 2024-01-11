import 'package:example/src/storybook/common/color_options.dart';
import 'package:example/src/storybook/common/widgets/text_divider.dart';
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class BreadcrumbStory extends StatelessWidget {
  static const path = '/breadcrumb';

  const BreadcrumbStory({super.key});
  @override
  Widget build(BuildContext context) {
    final textColorKnob = context.knobs.nullable.options(
      label: "itemTextColor",
      description: "MoonColors variants for MoonBreadcrumb item text.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final textColor = colorTable(context)[textColorKnob ?? 40];

    final hoverTextColorKnob = context.knobs.nullable.options(
      label: "itemTextHoverColor",
      description: "MoonColors variants for MoonBreadcrumb item text on hover.",
      enabled: false,
      initial: 0,
      // piccolo
      options: colorOptions,
    );

    final hoverTextColor = colorTable(context)[hoverTextColorKnob ?? 40];

    final currentItemColorKnob = context.knobs.nullable.options(
      label: "currentItemTextColor",
      description: "MoonColors variants for current MoonBreadcrumb item.",
      enabled: false,
      initial: 1,
      // hit
      options: colorOptions,
    );

    final currentItemTextColor = colorTable(context)[currentItemColorKnob ?? 40];

    final pageCountKnob = context.knobs.nullable.sliderInt(
      label: "pageCount",
      description: "Count of pages in MoonBreadcrumb.",
      initial: 7,
      max: 12,
    );

    final itemsToShowKnob = context.knobs.nullable.sliderInt(
      label: "itemsToShowCount",
      description: "Count of pages to show in MoonBreadcrumb.",
      initial: 3,
      max: 12,
    );

    final gapKnob = context.knobs.nullable.sliderInt(
      label: "gap",
      description: "Gap between MoonBreadcrumb items.",
      enabled: false,
      initial: 4,
      max: 16,
    );

    final showLabelKnob = context.knobs.boolean(
      label: "label",
      description: "Show widget in MoonBreadcrumb item label slot.",
      initial: true,
    );

    final showLeadingKnob = context.knobs.boolean(
      label: "leading",
      description: "Show widget in MoonBreadcrumb item leading slot.",
    );

    final isDisabledKnob = context.knobs.boolean(
      label: "isDisabled",
      description: "Disable MoonBreadcrumb.",
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextDivider(
            text: "MoonBreadcrumb",
            paddingTop: 0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: MoonBreadcrumb(
              itemsToShow: itemsToShowKnob,
              hoverTextColor: hoverTextColor,
              itemTextStyle: TextStyle(color: textColor),
              currentItemTextStyle: TextStyle(color: currentItemTextColor),
              gap: gapKnob?.toDouble(),
              items: [
                BreadcrumbItem(
                  leading: showLeadingKnob ? const Icon(MoonIcons.generic_home_16_light) : null,
                  label: showLabelKnob ? const Text('Home') : null,
                  onPressed:
                      isDisabledKnob ? null : () => MoonToast.show(context, label: const Text('Home page pressed')),
                ),
                ...List.generate(pageCountKnob ?? 3, (int i) => i).map(
                  (int index) => BreadcrumbItem(
                    label: Text('Page ${index + 1}'),
                    onPressed: isDisabledKnob
                        ? null
                        : () {
                            MoonToast.show(context, label: Text('Page ${index + 1} pressed'));
                          },
                  ),
                ),
              ],
            ),
          ),
          const TextDivider(text: "MoonBreadcrumb with custom divider and text style"),
          MoonBreadcrumb(
            itemTextStyle: context.moonTypography?.caption.text18,
            currentItemTextStyle: context.moonTypography?.heading.text20,
            divider: const Icon(
              Icons.chevron_right,
              size: 24,
            ),
            items: [
              BreadcrumbItem(
                label: const Text('Home'),
                onPressed: () {},
              ),
              BreadcrumbItem(
                label: const Text('Page 1'),
                onPressed: () {},
              ),
              BreadcrumbItem(
                label: const Text('Page 2'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
