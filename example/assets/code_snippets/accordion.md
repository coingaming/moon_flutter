import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

enum AccordionItems { first, second }

class Accordion extends StatefulWidget {
  const Accordion({super.key});

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  AccordionItems? _currentlyOpenAccordionItem = AccordionItems.first;

  @override
  Widget build(BuildContext context) {
    const String contentText = 
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
      "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, "
      "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";

    return Column(
      children: [
        MoonAccordion<AccordionItems>(
          // The identityValue and groupIdentityValue can be used to control the 
          // auto collapse behaviour of the accordion.
          identityValue: AccordionItems.first,
          groupIdentityValue: _currentlyOpenAccordionItem,
          accordionSize: MoonAccordionSize.sm,
          childrenPadding: const EdgeInsets.all(12),
          onExpansionChanged: (AccordionItems? value) => setState(
            () => _currentlyOpenAccordionItem = value,
          ),
          leading: const Icon(MoonIcons.other_frame_24_light),
          label: const Text("Grouped MoonAccordion item #1"),
          children: const [
            Text(contentText),
          ],
        ),
        MoonAccordion<AccordionItems>(
          // The identityValue and groupIdentityValue can be used to control the 
          // auto collapse behaviour of the accordion.
          identityValue: AccordionItems.second,
          groupIdentityValue: _currentlyOpenAccordionItem,
          accordionSize: MoonAccordionSize.sm,
          hasContentOutside: true,
          childrenPadding: const EdgeInsets.all(12),
          onExpansionChanged: (AccordionItems? value) => setState(
            () => _currentlyOpenAccordionItem = value,
          ),
          leading: const Icon(MoonIcons.other_frame_24_light),
          label: const Text("Grouped MoonAccordion item #2"),
          children: const [
            Text(contentText),
          ],
        ),
      ],
    );
  }
}