import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class Breadcrumb extends StatelessWidget {
  const Breadcrumb({super.key});

  @override
  Widget build(BuildContext context) {
    return MoonBreadcrumb(
      items: [
        BreadcrumbItem(
          leading: const Icon(MoonIcons.generic_home_16_light),
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
    );
  }
}