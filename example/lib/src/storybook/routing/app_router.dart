import 'package:example/src/storybook/routing/routing_error_widget.dart';
import 'package:example/src/storybook/stories/accordion.dart';
import 'package:example/src/storybook/stories/alert.dart';
import 'package:example/src/storybook/stories/auth_code.dart';
import 'package:example/src/storybook/stories/avatar.dart';
import 'package:example/src/storybook/stories/bottom_sheet.dart';
import 'package:example/src/storybook/stories/breadcrumb.dart';
import 'package:example/src/storybook/stories/button.dart';
import 'package:example/src/storybook/stories/carousel.dart';
import 'package:example/src/storybook/stories/checkbox.dart';
import 'package:example/src/storybook/stories/chip.dart';
import 'package:example/src/storybook/stories/circular_loader.dart';
import 'package:example/src/storybook/stories/circular_progress.dart';
import 'package:example/src/storybook/stories/combobox.dart';
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

const String primitivesDirectory = '/primitives';
const String compositesDirectory = '/composites';

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: AccordionStory.path,
  errorBuilder: (context, state) => const RoutingErrorWidget(),
  redirect: (context, state) {
    switch (state.uri.path) {
      case primitivesDirectory:
        return AccordionStory.path;
      case compositesDirectory:
        return ComboboxStory.path;
      case CircularLoaderStory.subdirectory:
        return CircularLoaderStory.path;
      case CircularProgressStory.subdirectory:
        return CircularProgressStory.path;
      case '$primitivesDirectory${CircularLoaderStory.subdirectory}':
        return CircularLoaderStory.path;
      case '$primitivesDirectory${CircularProgressStory.subdirectory}':
        return CircularProgressStory.path;
      default:
        return null;
    }
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) {
        Storybook.storyRouterNotifier.currentStoryRoute = AccordionStory.path;
        return AccordionStory.path;
      },
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
      path: BreadcrumbStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: BreadcrumbStory(),
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
      path: CircularLoaderStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: CircularLoaderStory(),
      ),
    ),
    GoRoute(
      path: CircularProgressStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: CircularProgressStory(),
      ),
    ),
    GoRoute(
      path: ComboboxStory.path,
      pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
        child: ComboboxStory(),
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
