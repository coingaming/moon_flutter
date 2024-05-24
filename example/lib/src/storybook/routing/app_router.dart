import 'package:example/src/storybook/common/pages/colors_page.dart';
import 'package:example/src/storybook/common/pages/home_page.dart';
import 'package:example/src/storybook/common/widgets/routing_error_widget.dart';
import 'package:example/src/storybook/stories/composites/combobox_multi_select.dart';
import 'package:example/src/storybook/stories/composites/combobox_single_select.dart';
import 'package:example/src/storybook/stories/composites/search_with_dropdown.dart';
import 'package:example/src/storybook/stories/composites/search_with_list.dart';
import 'package:example/src/storybook/stories/primitives/accordion.dart';
import 'package:example/src/storybook/stories/primitives/alert.dart';
import 'package:example/src/storybook/stories/primitives/auth_code.dart';
import 'package:example/src/storybook/stories/primitives/avatar.dart';
import 'package:example/src/storybook/stories/primitives/bottom_sheet.dart';
import 'package:example/src/storybook/stories/primitives/breadcrumb.dart';
import 'package:example/src/storybook/stories/primitives/button.dart';
import 'package:example/src/storybook/stories/primitives/carousel.dart';
import 'package:example/src/storybook/stories/primitives/checkbox.dart';
import 'package:example/src/storybook/stories/primitives/chip.dart';
import 'package:example/src/storybook/stories/primitives/circular_loader.dart';
import 'package:example/src/storybook/stories/primitives/circular_progress.dart';
import 'package:example/src/storybook/stories/primitives/dot_indicator.dart';
import 'package:example/src/storybook/stories/primitives/drawer.dart';
import 'package:example/src/storybook/stories/primitives/dropdown.dart';
import 'package:example/src/storybook/stories/primitives/icons.dart';
import 'package:example/src/storybook/stories/primitives/linear_loader.dart';
import 'package:example/src/storybook/stories/primitives/linear_progress.dart';
import 'package:example/src/storybook/stories/primitives/menu_item.dart';
import 'package:example/src/storybook/stories/primitives/modal.dart';
import 'package:example/src/storybook/stories/primitives/popover.dart';
import 'package:example/src/storybook/stories/primitives/radio.dart';
import 'package:example/src/storybook/stories/primitives/segmented_control.dart';
import 'package:example/src/storybook/stories/primitives/switch.dart';
import 'package:example/src/storybook/stories/primitives/tab_bar.dart';
import 'package:example/src/storybook/stories/primitives/table.dart';
import 'package:example/src/storybook/stories/primitives/tag.dart';
import 'package:example/src/storybook/stories/primitives/text_area.dart';
import 'package:example/src/storybook/stories/primitives/text_input.dart';
import 'package:example/src/storybook/stories/primitives/text_input_group.dart';
import 'package:example/src/storybook/stories/primitives/toast.dart';
import 'package:example/src/storybook/stories/primitives/tooltip.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const String primitivesDirectory = '/primitives';
const String compositesDirectory = '/composites';

GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: HomePage.path,
  errorBuilder: (BuildContext _, GoRouterState __) =>
      const RoutingErrorWidget(),
  redirect: (BuildContext _, GoRouterState state) {
    switch (state.uri.path) {
      case primitivesDirectory:
        return AccordionStory.path;
      case compositesDirectory:
        return ComboboxSingleSelectStory.path;

      case ComboboxSingleSelectStory.subdirectory:
        return ComboboxSingleSelectStory.path;
      case '$compositesDirectory${ComboboxSingleSelectStory.subdirectory}':
        return ComboboxSingleSelectStory.path;

      case SearchWithListStory.subdirectory:
        return SearchWithListStory.path;
      case '$compositesDirectory${SearchWithListStory.subdirectory}':
        return SearchWithListStory.path;

      case CircularLoaderStory.subdirectory:
        return CircularLoaderStory.path;
      case '$primitivesDirectory${CircularLoaderStory.subdirectory}':
        return CircularLoaderStory.path;

      case CircularProgressStory.subdirectory:
        return CircularProgressStory.path;
      case '$primitivesDirectory${CircularProgressStory.subdirectory}':
        return CircularProgressStory.path;
      default:
        return null;
    }
  },
  routes: <RouteBase>[
    // Pages.
    GoRoute(
      path: HomePage.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: HomePage(),
      ),
    ),
    GoRoute(
      path: ColorsPage.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: ColorsPage(),
      ),
    ),

    // Stories.
    GoRoute(
      path: AccordionStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: AccordionStory(),
      ),
    ),
    GoRoute(
      path: AlertStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: AlertStory(),
      ),
    ),
    GoRoute(
      path: AuthCodeStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: AuthCodeStory(),
      ),
    ),
    GoRoute(
      path: AvatarStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: AvatarStory(),
      ),
    ),
    GoRoute(
      path: BottomSheetStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: BottomSheetStory(),
      ),
      onExit: (BuildContext _) {
        if (router.canPop()) router.pop();
        return true;
      },
    ),
    GoRoute(
      path: BreadcrumbStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: BreadcrumbStory(),
      ),
    ),
    GoRoute(
      path: ButtonStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: ButtonStory(),
      ),
    ),
    GoRoute(
      path: CarouselStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: CarouselStory(),
      ),
    ),
    GoRoute(
      path: CheckboxStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: CheckboxStory(),
      ),
    ),
    GoRoute(
      path: ChipStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: ChipStory(),
      ),
    ),
    GoRoute(
      path: CircularLoaderStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: CircularLoaderStory(),
      ),
    ),
    GoRoute(
      path: CircularProgressStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: CircularProgressStory(),
      ),
    ),
    GoRoute(
      path: ComboboxSingleSelectStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: ComboboxSingleSelectStory(),
      ),
    ),
    GoRoute(
      path: ComboboxMultiSelectStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: ComboboxMultiSelectStory(),
      ),
    ),
    GoRoute(
      path: DotIndicatorStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: DotIndicatorStory(),
      ),
    ),
    GoRoute(
      path: DrawerStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: DrawerStory(),
      ),
    ),
    GoRoute(
      path: DropdownStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: DropdownStory(),
      ),
    ),
    GoRoute(
      path: IconsStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: IconsStory(),
      ),
    ),
    GoRoute(
      path: LinearLoaderStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: LinearLoaderStory(),
      ),
    ),
    GoRoute(
      path: LinearProgressStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: LinearProgressStory(),
      ),
    ),
    GoRoute(
      path: MenuItemStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: MenuItemStory(),
      ),
    ),
    GoRoute(
      path: ModalStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: ModalStory(),
      ),
      onExit: (BuildContext _) {
        if (router.canPop()) router.pop();
        return true;
      },
    ),
    GoRoute(
      path: PopoverStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: PopoverStory(),
      ),
    ),
    GoRoute(
      path: RadioStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: RadioStory(),
      ),
    ),
    GoRoute(
      path: SearchWithListStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: SearchWithListStory(),
      ),
    ),
    GoRoute(
      path: SearchWithDropdownStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: SearchWithDropdownStory(),
      ),
    ),
    GoRoute(
      path: SegmentedControlStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: SegmentedControlStory(),
      ),
    ),
    GoRoute(
      path: SwitchStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: SwitchStory(),
      ),
    ),
    GoRoute(
      path: TabBarStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: TabBarStory(),
      ),
    ),
    GoRoute(
      path: TableStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: TableStory(),
      ),
    ),
    GoRoute(
      path: TagStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: TagStory(),
      ),
    ),
    GoRoute(
      path: TextAreaStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: TextAreaStory(),
      ),
    ),
    GoRoute(
      path: TextInputStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: TextInputStory(),
      ),
    ),
    GoRoute(
      path: TextInputGroupStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: TextInputGroupStory(),
      ),
    ),
    GoRoute(
      path: ToastStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: ToastStory(),
      ),
    ),
    GoRoute(
      path: TooltipStory.path,
      pageBuilder: (BuildContext _, GoRouterState __) => const NoTransitionPage(
        child: TooltipStory(),
      ),
    ),
  ],
);
