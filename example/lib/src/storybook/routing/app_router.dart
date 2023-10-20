import 'package:auto_route/auto_route.dart';
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
import 'package:storybook_flutter/storybook_flutter.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Story,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AccordionRoute.page, path: '/accordion', initial: true),
        AutoRoute(page: AlertRoute.page, path: '/alert'),
        AutoRoute(page: AuthCodeRoute.page, path: '/auth_code'),
        AutoRoute(page: AvatarRoute.page, path: '/avatar'),
        AutoRoute(page: BottomSheetRoute.page, path: '/bottom_sheet'),
        AutoRoute(page: ButtonRoute.page, path: '/button'),
        AutoRoute(page: CarouselRoute.page, path: '/carousel'),
        AutoRoute(page: CheckboxRoute.page, path: '/checkbox'),
        AutoRoute(page: ChipRoute.page, path: '/chip'),
        AutoRoute(page: CircularLoaderRoute.page, path: '/loader/circular_loader'),
        AutoRoute(page: CircularProgressRoute.page, path: '/progress/circular_progress'),
        AutoRoute(page: DotIndicatorRoute.page, path: '/dot_indicator'),
        AutoRoute(page: DrawerRoute.page, path: '/drawer'),
        AutoRoute(page: DropdownRoute.page, path: '/dropdown'),
        AutoRoute(page: IconsRoute.page, path: '/icons'),
        AutoRoute(page: LinearLoaderRoute.page, path: '/loader/linear_loader'),
        AutoRoute(page: LinearProgressRoute.page, path: '/progress/linear_progress'),
        AutoRoute(page: MenuItemRoute.page, path: '/menu_item'),
        AutoRoute(page: ModalRoute.page, path: '/modal'),
        AutoRoute(page: PopoverRoute.page, path: '/popover'),
        AutoRoute(page: RadioRoute.page, path: '/radio'),
        AutoRoute(page: SegmentedControlRoute.page, path: '/segmented_control'),
        AutoRoute(page: SwitchRoute.page, path: '/switch'),
        AutoRoute(page: TabBarRoute.page, path: '/tab_bar'),
        AutoRoute(page: TableRoute.page, path: '/table'),
        AutoRoute(page: TagRoute.page, path: '/tag'),
        AutoRoute(page: TextAreaRoute.page, path: '/text_area'),
        AutoRoute(page: TextInputRoute.page, path: '/text_input'),
        AutoRoute(page: TextInputGroupRoute.page, path: '/text_input_group'),
        AutoRoute(page: ToastRoute.page, path: '/toast'),
        AutoRoute(page: TooltipRoute.page, path: '/tooltip'),
      ];
}

final List<Story> routeAwareStories = [
  Story.asRoute(
    name: 'Accordion',
    initialRoutes: const [AccordionRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Alert',
    initialRoutes: const [AlertRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'AuthCode',
    initialRoutes: const [AuthCodeRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Avatar',
    initialRoutes: const [AvatarRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'BottomSheet',
    initialRoutes: const [BottomSheetRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Button',
    initialRoutes: const [ButtonRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Carousel',
    initialRoutes: const [CarouselRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Checkbox',
    initialRoutes: const [CheckboxRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Chip',
    initialRoutes: const [ChipRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Loader/CircularLoader',
    initialRoutes: const [CircularLoaderRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Progress/CircularProgress',
    initialRoutes: const [CircularProgressRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'DotIndicator',
    initialRoutes: const [DotIndicatorRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Drawer',
    initialRoutes: const [DrawerRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Dropdown',
    initialRoutes: const [DropdownRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Loader/LinearLoader',
    initialRoutes: const [LinearLoaderRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Progress/LinearProgress',
    initialRoutes: const [LinearProgressRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'MenuItem',
    initialRoutes: const [MenuItemRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Modal',
    initialRoutes: const [ModalRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Popover',
    initialRoutes: const [PopoverRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Radio',
    initialRoutes: const [RadioRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'SegmentedControl',
    initialRoutes: const [SegmentedControlRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Switch',
    initialRoutes: const [SwitchRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'TabBar',
    initialRoutes: const [TabBarRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Table',
    initialRoutes: const [TableRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Tag',
    initialRoutes: const [TagRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'TextArea',
    initialRoutes: const [TextAreaRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'TextInput',
    initialRoutes: const [TextInputRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'TextInputGroup',
    initialRoutes: const [TextInputGroupRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Toast',
    initialRoutes: const [ToastRoute()],
    router: AppRouter(),
  ),
  Story.asRoute(
    name: 'Tooltip',
    initialRoutes: const [TooltipRoute()],
    router: AppRouter(),
  ),
];
