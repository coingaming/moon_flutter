import 'package:example/src/storybook/routing/routing_error_widget.dart';
import 'package:example/src/storybook/stories/accordion.dart';
import 'package:example/src/storybook/stories/alert.dart';
import 'package:example/src/storybook/stories/auth_code.dart';
import 'package:example/src/storybook/stories/avatar.dart';
import 'package:example/src/storybook/stories/bottom_sheet.dart';
import 'package:example/src/storybook/stories/button.dart';
import 'package:example/src/storybook/stories/carousel.dart';
import 'package:example/src/storybook/stories/checkbox.dart';
import 'package:example/src/storybook/stories/chip.dart';
import 'package:example/src/storybook/stories/circular_loader.dart';
import 'package:example/src/storybook/stories/circular_progress.dart';
import 'package:example/src/storybook/stories/dot_indicator.dart';
import 'package:example/src/storybook/stories/drawer.dart';
import 'package:example/src/storybook/stories/dropdown.dart';
import 'package:example/src/storybook/stories/icons.dart';
import 'package:example/src/storybook/stories/linear_loader.dart';
import 'package:example/src/storybook/stories/linear_progress.dart';
import 'package:example/src/storybook/stories/menu_item.dart';
import 'package:example/src/storybook/stories/modal.dart';
import 'package:example/src/storybook/stories/popover.dart';
import 'package:example/src/storybook/stories/radio.dart';
import 'package:example/src/storybook/stories/segmented_control.dart';
import 'package:example/src/storybook/stories/switch.dart';
import 'package:example/src/storybook/stories/tab_bar.dart';
import 'package:example/src/storybook/stories/table.dart';
import 'package:example/src/storybook/stories/tag.dart';
import 'package:example/src/storybook/stories/text_area.dart';
import 'package:example/src/storybook/stories/text_input.dart';
import 'package:example/src/storybook/stories/text_input_group.dart';
import 'package:example/src/storybook/stories/toast.dart';
import 'package:example/src/storybook/stories/tooltip.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: AccordionStory.path,
  errorBuilder: (context, state) => const RoutingErrorWidget(),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) {
        Storybook.storyRouterNotifier.currentStoryRoute = AccordionStory.path;
        return AccordionStory.path;
      },
    ),
    GoRoute(
      path: CircularLoaderStory.subdirectory,
      redirect: (BuildContext context, GoRouterState state) => CircularLoaderStory.path,
      routes: [
        GoRoute(
          path: CircularLoaderStory.segment,
          pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
            child: CircularLoaderStory(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: CircularProgressStory.subdirectory,
      redirect: (BuildContext context, GoRouterState state) => CircularProgressStory.path,
      routes: [
        GoRoute(
          path: CircularProgressStory.segment,
          pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
            child: CircularProgressStory(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: AccordionStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: AccordionStory(),
      ),
    ),
    GoRoute(
      path: AlertStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: AlertStory(),
      ),
    ),
    GoRoute(
      path: AuthCodeStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: AuthCodeStory(),
      ),
    ),
    GoRoute(
      path: AvatarStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: AvatarStory(),
      ),
    ),
    GoRoute(
      path: BottomSheetStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: BottomSheetStory(),
      ),
    ),
    GoRoute(
      path: ButtonStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: ButtonStory(),
      ),
    ),
    GoRoute(
      path: CarouselStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: CarouselStory(),
      ),
    ),
    GoRoute(
      path: CheckboxStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: CheckboxStory(),
      ),
    ),
    GoRoute(
      path: ChipStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: ChipStory(),
      ),
    ),
    GoRoute(
      path: DotIndicatorStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: DotIndicatorStory(),
      ),
    ),
    GoRoute(
      path: DrawerStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: DrawerStory(),
      ),
    ),
    GoRoute(
      path: DropdownStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: DropdownStory(),
      ),
    ),
    GoRoute(
      path: IconsStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: IconsStory(),
      ),
    ),
    GoRoute(
      path: LinearLoaderStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: LinearLoaderStory(),
      ),
    ),
    GoRoute(
      path: LinearProgressStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: LinearProgressStory(),
      ),
    ),
    GoRoute(
      path: MenuItemStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: MenuItemStory(),
      ),
    ),
    GoRoute(
      path: ModalStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: ModalStory(),
      ),
    ),
    GoRoute(
      path: PopoverStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: PopoverStory(),
      ),
    ),
    GoRoute(
      path: RadioStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: RadioStory(),
      ),
    ),
    GoRoute(
      path: SegmentedControlStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: SegmentedControlStory(),
      ),
    ),
    GoRoute(
      path: SwitchStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: SwitchStory(),
      ),
    ),
    GoRoute(
      path: TabBarStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: TabBarStory(),
      ),
    ),
    GoRoute(
      path: TableStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: TableStory(),
      ),
    ),
    GoRoute(
      path: TagStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: TagStory(),
      ),
    ),
    GoRoute(
      path: TextAreaStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: TextAreaStory(),
      ),
    ),
    GoRoute(
      path: TextInputStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: TextInputStory(),
      ),
    ),
    GoRoute(
      path: TextInputGroupStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: TextInputGroupStory(),
      ),
    ),
    GoRoute(
      path: ToastStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: ToastStory(),
      ),
    ),
    GoRoute(
      path: TooltipStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: TooltipStory(),
      ),
    ),
  ],
);

final List<Story> routeAwareStories = [
  Story.asRoute(
    name: 'Accordion',
    routePath: AccordionStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Alert',
    routePath: AlertStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'AuthCode',
    routePath: AuthCodeStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Avatar',
    routePath: AvatarStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'BottomSheet',
    routePath: BottomSheetStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Button',
    routePath: ButtonStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Carousel',
    routePath: CarouselStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Checkbox',
    routePath: CheckboxStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Chip',
    routePath: ChipStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Loader/CircularLoader',
    routePath: CircularLoaderStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Progress/CircularProgress',
    routePath: CircularProgressStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'DotIndicator',
    routePath: DotIndicatorStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Drawer',
    routePath: DrawerStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Dropdown',
    routePath: DropdownStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Icons',
    routePath: IconsStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Loader/LinearLoader',
    routePath: LinearLoaderStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Progress/LinearProgress',
    routePath: LinearProgressStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'MenuItem',
    routePath: MenuItemStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Modal',
    routePath: ModalStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Popover',
    routePath: PopoverStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Radio',
    routePath: RadioStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'SegmentedControl',
    routePath: SegmentedControlStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Switch',
    routePath: SwitchStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'TabBar',
    routePath: TabBarStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Table',
    routePath: TableStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Tag',
    routePath: TagStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'TextArea',
    routePath: TextAreaStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'TextInput',
    routePath: TextInputStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'TextInputGroup',
    routePath: TextInputGroupStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Toast',
    routePath: ToastStory.path,
    router: router,
  ),
  Story.asRoute(
    name: 'Tooltip',
    routePath: TooltipStory.path,
    router: router,
  ),
];
